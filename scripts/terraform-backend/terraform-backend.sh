#!/bin/bash

set -eu

CONFIG_FILE=${1:?"CONFIG_FILE is unset or null"}
readonly CONFIG_FILE

LOCATION=${2:?"LOCATION is unset or null"}
readonly CONFIG_FILE

IP_ADDRESSES=${3:-""}
readonly IP_ADDRESSES

error() {
  echo -e "\033[0;31mERROR: $*\033[0;37m" >&2
}

################################################################################
# Verify installation of necessary software components
################################################################################

hash az 2>/dev/null || {
  error "Azure CLI not found in PATH."
  exit 1
}

hash jq 2>/dev/null || {
  error "jq not found in PATH."
  exit 1
}

################################################################################
# Verify target Azure subscription
################################################################################

SUBSCRIPTION_NAME=$(az account show --query name --output tsv)
readonly SUBSCRIPTION_NAME

read -r -p "Create Terraform backend in \
Azure subscription '$SUBSCRIPTION_NAME'? (y/N) " response
case "$response" in
[yY][eE][sS] | [yY])
  echo "Proceeding with creation..."
  ;;
*)
  echo "Exiting without creating..."
  exit 0
  ;;
esac

################################################################################
# Read Terraform backend configuration
################################################################################

if [[ -f "$CONFIG_FILE" ]]; then
  echo "Using config file '$CONFIG_FILE'."
else
  echo "Config file '$CONFIG_FILE' does not exist."
  exit 1
fi

CONFIG=$(cat "$CONFIG_FILE")
readonly CONFIG

RESOURCE_GROUP_NAME=$(echo "$CONFIG" | jq -r .resource_group_name)
readonly RESOURCE_GROUP_NAME

STORAGE_ACCOUNT_NAME=$(echo "$CONFIG" | jq -r .storage_account_name)
readonly STORAGE_ACCOUNT_NAME

CONTAINER_NAME=$(echo "$CONFIG" | jq -r .container_name)
readonly CONTAINER_NAME

USE_AZUREAD_AUTH=$(echo "$CONFIG" | jq -r .use_azuread_auth)
readonly USE_AZUREAD_AUTH

################################################################################
# Check if Azure Storage account is locked
################################################################################

STORAGE_ACCOUNT_ID=$(az storage account list \
  --resource-group "$RESOURCE_GROUP_NAME" \
  --query "[?name == '$STORAGE_ACCOUNT_NAME'].id" \
  --output tsv)

LOCK_NAME="Terraform"
readonly LOCK_NAME

LOCK_ID=""
if [[ -n "$STORAGE_ACCOUNT_ID" ]]; then
  LOCK_ID=$(az resource lock list \
    --resource "$STORAGE_ACCOUNT_ID" \
    --query "[?name == '$LOCK_NAME'].id" \
    --output tsv)
fi
readonly LOCK_ID

if [[ -n "$LOCK_ID" ]]; then
  error "Storage account is locked. \
Please remove the lock by running the following command:"
  echo -e "\n\033[0;36maz resource lock delete --ids $LOCK_ID\033[0m\n"
  exit 1
fi

################################################################################
# Create Azure resource group
################################################################################

echo "Creating resource group..."
az group create \
  --name "$RESOURCE_GROUP_NAME" \
  --location "$LOCATION" \
  --output none

################################################################################
# Create Azure Storage account
################################################################################

HTTPS_ONLY="true"
readonly HTTPS_ONLY

MIN_TLS_VERSION="TLS1_2"
readonly MIN_TLS_VERSION

ALLOW_BLOB_PUBLIC_ACCESS="false"
readonly ALLOW_BLOB_PUBLIC_ACCESS

ALLOW_SHARED_KEY_ACCESS="false"
if [[ "$USE_AZUREAD_AUTH" != "true" ]]; then
  ALLOW_SHARED_KEY_ACCESS="true"
fi
readonly ALLOW_SHARED_KEY_ACCESS

ALLOW_CROSS_TENANT_REPLICATION="false"
readonly ALLOW_CROSS_TENANT_REPLICATION

DEFAULT_ACTION="Deny"
if [[ -z "$IP_ADDRESSES" ]]; then
  DEFAULT_ACTION="Allow"
fi
readonly DEFAULT_ACTION

if [[ -z "$STORAGE_ACCOUNT_ID" ]]; then
  echo "Creating storage account..."
  STORAGE_ACCOUNT_ID="$(az storage account create \
    --name "$STORAGE_ACCOUNT_NAME" \
    --resource-group "$RESOURCE_GROUP_NAME" \
    --location "$LOCATION" \
    --sku Standard_GRS \
    --access-tier Hot \
    --kind StorageV2 \
    --https-only "$HTTPS_ONLY" \
    --min-tls-version "$MIN_TLS_VERSION" \
    --allow-blob-public-access "$ALLOW_BLOB_PUBLIC_ACCESS" \
    --allow-shared-key-access "$ALLOW_SHARED_KEY_ACCESS" \
    --allow-cross-tenant-replication "$ALLOW_CROSS_TENANT_REPLICATION" \
    --default-action "$DEFAULT_ACTION" \
    --query id \
    --output tsv)"
else
  echo "Updating existing storage account..."
  az storage account update \
    --name "$STORAGE_ACCOUNT_NAME" \
    --resource-group "$RESOURCE_GROUP_NAME" \
    --https-only "$HTTPS_ONLY" \
    --min-tls-version "$MIN_TLS_VERSION" \
    --allow-blob-public-access "$ALLOW_BLOB_PUBLIC_ACCESS" \
    --allow-shared-key-access "$ALLOW_SHARED_KEY_ACCESS" \
    --allow-cross-tenant-replication "$ALLOW_CROSS_TENANT_REPLICATION" \
    --default-action "$DEFAULT_ACTION" \
    --output none
fi

# Network rule must be added before updating Blob service properties.
for ip_address in $IP_ADDRESSES; do
  az storage account network-rule add \
    --account-name "${STORAGE_ACCOUNT_NAME}" \
    --resource-group "${RESOURCE_GROUP_NAME}" \
    --ip-address "${ip_address}" \
    --output none
done

az storage account blob-service-properties update \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --resource-group "$RESOURCE_GROUP_NAME" \
  --enable-delete-retention true \
  --delete-retention-days 30 \
  --enable-container-delete-retention true \
  --container-delete-retention-days 30 \
  --enable-versioning true \
  --enable-change-feed true \
  --output none

az security atp storage update \
  --storage-account "$STORAGE_ACCOUNT_NAME" \
  --resource-group "$RESOURCE_GROUP_NAME" \
  --is-enabled true \
  --output none

################################################################################
# Create Azure Storage container
################################################################################

echo "Creating storage container..."
az storage container create \
  --name "$CONTAINER_NAME" \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --auth-mode login \
  --output none

################################################################################
# Create Azure Storage lifecycle policy
################################################################################

echo "Creating lifecycle policy..."
POLICY=$(echo "$CONFIG" | jq '{
  rules: [
    {
      name: "Delete old tfstate versions",
      enabled: true,
      type: "Lifecycle",
      definition: {
        actions: {
          version: {
            delete: {
              daysAfterCreationGreaterThan: 30,
            }
          }
        },
        filters: {
          blobTypes: [
            "blockBlob"
          ],
          prefixMatch: [
            .container_name
          ]
        }
      }
    }
  ]
}')
readonly POLICY

az storage account management-policy create \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --resource-group "$RESOURCE_GROUP_NAME" \
  --policy "$POLICY" \
  --output none

################################################################################
# Create Azure resource lock
################################################################################

echo "Creating resource lock..."
az resource lock create \
  --name "$LOCK_NAME" \
  --lock-type ReadOnly \
  --resource "$STORAGE_ACCOUNT_ID" \
  --notes "Prevent changes to Terraform backend configuration" \
  --output none
