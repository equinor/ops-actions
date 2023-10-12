# Terraform backend script

This directory contains a script `terraform-backend.sh` that will create an Azure Storage account that can be used as a Terraform backend.

It accepts the following arguments:

1. The Azure region to create the storage account in.
1. The path of the JSON file containing the Terraform backend configuration.

## Prerequisites

- [Install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) (latest version as of writing: `2.49.0`) - to create Azure resource group, storage account and container
- [Install jq](https://stedolan.github.io/jq/download/) (latest version as of writing: `1.6`) - to parse JSON config file
- Azure role `Owner` at the subscription scope.

## Configuration specification

Example configuration:

```json
{
  "resource_group_name": "tfstate",
  "storage_account_name": "tfstate32417",
  "container_name": "tfstate",
  "use_azuread_auth": true
}
```

> **Note**
>
> `.use_azuread_auth` should be `true`.

## Usage

1. Login to Azure:

    ```console
    az login
    ```

1. Set Azure subscription:

    ```console
    az account set -s <SUBSCRIPTION_NAME_OR_ID>
    ```

1. Configure resource group name, storage account name and container name in a file `*.azurerm.tfbackend.json`,
   e.g. `dev.azurerm.tfbackend.json`.

1. Run the script:

    ```console
    ./terraform-backend.sh <LOCATION> <CONFIG_FILE>
    ```

    For example:

    ```console
    ./terraform-backend.sh northeurope dev.azurerm.tfbackend.json
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
