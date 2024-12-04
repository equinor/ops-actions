# Terraform backend

This directory contains a Bicep template that will create an Azure Storage account that can be used as a Terraform backend.

## Prerequisites

- Install [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).
- Activate Azure role `Owner`.

## Usage

1. Login to Azure:

    ```console
    az login
    ```

1. Set active subscription:

    ```console
    az account set -s <SUBSCRIPTION_NAME_OR_ID>
    ```

1. Create a resource group:

    ```console
    az group create -n <RESOURCE_GROUP_NAME>
    ```

1. Deploy the Bicep template to the resource group:

    ```console
    az deployment group create --resource-group <RESOURCE_GROUP_NAME> --template-uri https://github.com/equinor/ops-actions/blob/main/scripts/terraform-backend/main.bicep
    ```

## References

- [Store Terraform state in Azure Storage](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli)
- [Security recommendations for Azure Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/security-recommendations)
- [Terraform backend configuration for Azure Storage](https://www.terraform.io/language/settings/backends/azurerm)
