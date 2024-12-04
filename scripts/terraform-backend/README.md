# Terraform backend

This directory contains a Bicep template that will create an Azure Storage account in a given resource group that can be used as a Terraform backend.

## Prerequisites

- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).
- Azure role `Owner` at the resource group scope.

## Usage

1. Login to Azure:

   ```console
   az login
   ```

1. Set active subscription:

   ```console
   az account set -s <SUBSCRIPTION_NAME_OR_ID>
   ```

1. If you do not have one already, create a resource group:

   ```console
   az group create -n <RESOURCE_GROUP_NAME>
   ```

   > [!NOTE]
   > Requires Azure role `Contributor` at the subscription scope.

1. Deploy the Bicep template to the resource group:

   ```console
   az deployment group create -g <RESOURCE_GROUP_NAME> --template-uri https://github.com/equinor/ops-actions/blob/main/scripts/terraform-backend/main.bicep
   ```

## References

- [Store Terraform state in Azure Storage](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli)
- [Security recommendations for Azure Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/security-recommendations)
- [Terraform backend configuration for Azure Storage](https://www.terraform.io/language/settings/backends/azurerm)
