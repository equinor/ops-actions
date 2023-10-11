# Terraform backend script

This directory contains a script `terraform-backend.sh` that will create an Azure Storage account that can be used as a Terraform backend.

It accepts the following arguments:

1. The name of the storage account to create.
1. The name of the Azure resource group to create the storage account in.
1. The Azure region to create the storage account in.

## Prerequisites

- [Install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) (latest version as of writing: `2.49.0`).
- [Install jq](https://stedolan.github.io/jq/download/) (latest version as of writing: `1.6`) - to create lifecycle management policy.
- Azure role `Owner` at the subscription scope.

## Usage

1. Login to Azure:

    ```console
    az login
    ```

1. Set active subscription:

    ```console
    az account set -s <SUBSCRIPTION_NAME_OR_ID>
    ```

1. Run the script:

    ```console
    ./terraform-backend.sh <STORAGE_ACCOUNT_NAME> <RESOURCE_GROUP_NAME> <LOCATION>
    ```

    For example:

    ```console
    ./terraform-backend.sh tfstate$RANDOM tfstate northeurope
    ```

1. Configure OIDC to authenticate from GitHub Actions to the Terraform backend using the [OIDC script](../oidc/README.md).

    The JSON file containing the OIDC configuration must contain the following role assignment:

    ```json
    {
      "role": "Storage Blob Data Owner",
      "scope": "/subscriptions/${SUBSCRIPTION_ID}/resourceGroups/<RESOURCE_GROUP_NAME>/storageAccounts/<STORAGE_ACCOUNT_NAME>"
    }
    ```

## References

- [Store Terraform state in Azure Storage](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli)
- [Security recommendations for Azure Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/security-recommendations)
- [Terraform backend configuration for Azure Storage](https://www.terraform.io/language/settings/backends/azurerm)
