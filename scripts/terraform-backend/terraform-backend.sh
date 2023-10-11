#!/bin/bash

set -eu

readonly STORAGE_ACCOUNT_NAME=${1:?"STORAGE_ACCOUNT_NAME is unset or null"}
readonly RESOURCE_GROUP_NAME=${2:?"RESOURCE_GROUP_NAME is unset or null"}
readonly LOCATION=${3:?"LOCATION is unset or null"}
readonly CONTAINER_NAME="tfstate"

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
  --allow-cross-tenant-replication false \
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

management_policy=$(jq --null-input '{
  rules: [
    {
      name: "delete-old-versions",
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
          ]
        }
      }
    }
  ]
}')

az storage account management-policy create \
  --account-name "${STORAGE_ACCOUNT_NAME}" \
  --resource-group "${RESOURCE_GROUP_NAME}" \
  --policy "${management_policy}" \
  --output none

az resource lock create \
  --name 'Terraform' \
  --lock-type CanNotDelete \
  --resource "${storage_account_id}" \
  --notes "Prevent deletion of Terraform backend" \
  --output none

echo "resource_group_name = \"${RESOURCE_GROUP_NAME}\"
storage_account_name = \"${STORAGE_ACCOUNT_NAME}\"
container_name = \"${CONTAINER_NAME}\"
use_azuread_auth = true"
