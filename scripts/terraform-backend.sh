#!/bin/bash
#
# Creates an Azure storage account for storing remote Terraform state.
# Requires Azure role 'Owner' at the subscription scope.
# Arguments:
#   Azure region to create the storage account in, a name.
#   Azure AD object that should manage the remote Terraform state, an ID.
# Outputs:
#   Terraform backend configuration.

set -eu

readonly RESOURCE_GROUP_NAME='tfstate'
readonly LOCATION="$1"
readonly STORAGE_ACCOUNT_NAME="tfstate${RANDOM}"
readonly CONTAINER_NAME='tfstate'
readonly OBJECT_ID="$2"

az group create \
  --name "${RESOURCE_GROUP_NAME}" \
  --location "${LOCATION}" \
  --output none

storage_account_id="$(az storage account create \
  --name "${STORAGE_ACCOUNT_NAME}" \
  --resource-group "${RESOURCE_GROUP_NAME}" \
  --location "${LOCATION}" \
  --sku Standard_GRS \
  --access-tier Hot \
  --kind BlobStorage \
  --https-only true \
  --min-tls-version TLS1_2 \
  --allow-blob-public-access false \
  --allow-shared-key-access false \
  --query id \
  --output tsv)"

az storage account blob-service-properties update \
  --account-name "${STORAGE_ACCOUNT_NAME}" \
  --resource-group "${RESOURCE_GROUP_NAME}" \
  --enable-delete-retention true \
  --delete-retention-days 30 \
  --enable-container-delete-retention true \
  --container-delete-retention-days 30 \
  --enable-versioning true \
  --enable-change-feed true \
  --output none

az security atp storage update \
  --storage-account "${STORAGE_ACCOUNT_NAME}" \
  --resource-group "${RESOURCE_GROUP_NAME}" \
  --is-enabled true \
  --output none

az storage container create \
  --name "${CONTAINER_NAME}" \
  --account-name "${STORAGE_ACCOUNT_NAME}" \
  --auth-mode login \
  --output none

az role assignment create \
  --assignee "${OBJECT_ID}" \
  --role 'Storage Blob Data Owner' \
  --scope "${storage_account_id}" \
  --output none

az resource lock create \
  --name 'Terraform' \
  --lock-type ReadOnly \
  --resource "${storage_account_id}" \
  --notes 'Prevent changes to Terraform backend configuration' \
  --output none

echo "resource_group_name = \"${RESOURCE_GROUP_NAME}\"
storage_account_name = \"${STORAGE_ACCOUNT_NAME}\"
container_name = \"${CONTAINER_NAME}\"
use_azuread_auth = true"
