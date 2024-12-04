# Terraform backend script

This directory contains a Bicep template `terraform-backend.bicep` that will create an Azure Storage account that can be used as a Terraform backend.

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

1. Set active subscription:

    ```console
    az account set -s <SUBSCRIPTION_NAME_OR_ID>
    ```

1. Create resource group:

    ```console
    az group create -n tfstate
    ```

1. Deploy the template:

    ```console
    az deployment group create -g tfstate --template-file terraform-backend.bicep
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
