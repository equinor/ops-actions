# Terraform backend script

This directory contains a script `terraform-backend.sh` that will create an Azure Storage account that can be used as a Terraform backend.

It accepts the following arguments:

1. The path of the JSON file containing the Terraform backend configuration.
1. The Azure region to create the storage account in.
1. The object ID of the user, group or service principal that should have access to the backend.
1. (Optional) A space-separated string of IP addresses (or IP address ranges) that should have access to the backend.

## Prerequisites

- [Install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) - to create Azure resource group, storage account and container:

    ```console
    winget install Microsoft.AzureCLI
    ```

- [Install jq](https://stedolan.github.io/jq/download/) - to parse JSON config file:

    ```console
    winget install jqlang.jq
    ```

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
    ./terraform-backend.sh <CONFIG_FILE> <LOCATION> <OBJECT_ID> [<IP_ADDRESSES>]
    ```

    For example:

    ```console
    ./terraform-backend.sh dev.azurerm.tfbackend.json northeurope 42a1284c-b0b1-4a64-afab-1a89ec7d0ac9
    ```

    Restrict access to a list of IP addresses:

     ```console
    ./terraform-backend.sh dev.azurerm.tfbackend.json northeurope 42a1284c-b0b1-4a64-afab-1a89ec7d0ac9 "1.1.1.1 2.2.2.2 3.3.3.3"
    ```

## Troubleshooting

- If running the script in Git Bash, you might encounter the following error message: `The request did not have a subscription or a valid tenant level resource provider.`. To fix this error, set the following environment variable: `export MSYS_NO_PATHCONV=1`.

## References

- [Store Terraform state in Azure Storage](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli)
- [Security recommendations for Azure Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/security-recommendations)
- [Terraform backend configuration for Azure Storage](https://www.terraform.io/language/settings/backends/azurerm)
