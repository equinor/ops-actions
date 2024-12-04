# Create Terraform backend

This directory contains a Bicep template that will create an Azure Storage account that can be used to store Terraform state files.

## Prerequisites

- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).
- Azure role `Owner` at the resource group scope.

## Usage

### Create Azure Storage account

1. Login to Azure:

   ```console
   az login
   ```

1. Set active subscription:

   ```console
   az account set --name <SUBSCRIPTION_NAME>
   ```

1. Create a resource group:

    ```console
    az group create --name tfstate --location northeurope
    ```

1. Deploy the Bicep template to the resource group:

   ```console
   az deployment group create --resource-group tfstate --template-uri https://github.com/equinor/ops-actions/blob/main/scripts/terraform-backend/main.bicep --parameters storageAccountName=<STORAGE_ACCOUNT_NAME>
   ```

### Configure Terraform backend

In your Terraform configuration file, add the following backend configuration:

```terraform
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "<STORAGE_ACCOUNT_NAME>"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_azuread_auth     = true
  }
}
```

## References

- [Store Terraform state in Azure Storage](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli)
- [Security recommendations for Azure Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/security-recommendations)
- [Terraform backend configuration for Azure Storage](https://www.terraform.io/language/settings/backends/azurerm)
