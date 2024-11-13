# Terraform backend script

This directory contains a script `terraform-backend.sh` that will create an Azure Storage account that can be used as a Terraform backend.

It accepts the following arguments:

1. The path of the JSON file containing the Terraform backend configuration.
1. The Azure region to create the storage account in.

## Prerequisites

- [Install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) - to create Azure resource group and Storage account.
- [Install jq](https://stedolan.github.io/jq/download/) - to parse JSON configuration file.
- Azure role `Owner` - to create Azure resource group and Storage account.

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
    ./terraform-backend.sh <CONFIG_FILE> <LOCATION>
    ```

    For example:

    ```console
    ./terraform-backend.sh dev.azurerm.tfbackend.json northeurope
    ```

## Access control

- If `use_azuread_auth` is set to `true` in the Terraform backend configuration, Azure role `Storage Blob Data Owner` is required at the Storage account scope or higher.
- Else, Azure role `Reader and Data Access` is required at the Storage account scope or higher.

## Troubleshooting

- If running the script in Git Bash, you might encounter the following error message: `The request did not have a subscription or a valid tenant level resource provider.`. To fix this error, set the following environment variable: `export MSYS_NO_PATHCONV=1`.

## References

- [Store Terraform state in Azure Storage](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli)
- [Security recommendations for Azure Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/security-recommendations)
- [Terraform backend configuration for Azure Storage](https://www.terraform.io/language/settings/backends/azurerm)
