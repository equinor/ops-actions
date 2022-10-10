#!/bin/bash

set -eu

readonly STORAGE_ACCOUNT_NAME="$1"
readonly RESOURCE_GROUP_NAME="$2"
readonly LOCATION="$3"
readonly CONTAINER_NAME='tfstate'
readonly OBJECT_ID="$4"

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
