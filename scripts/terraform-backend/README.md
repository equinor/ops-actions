# Terraform backend script

This directory contains a script `terraform-backend.sh` that will create an Azure Storage account that can be used as a Terraform backend.

It accepts the following arguments:

1. The name of the storage account to create.
1. The name of the Azure resource group to create the storage account in.
1. The Azure region to create the storage account in.
1. (Optional) The object ID of the Azure AD service principal that should be authorized to access the storage account.

## Prerequisites

- [Install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Activate Azure role](https://learn.microsoft.com/en-us/azure/active-directory/privileged-identity-management/pim-resource-roles-activate-your-roles) `Owner` at the subscription scope.

## Usage

1. Login to Azure:

    ```bash
    az login
    ```

1. Set active subscription:

    ```bash
    az account set -s <SUBSCRIPTION_NAME_OR_ID>
    ```

1. Run the script:

    ```bash
    ./terraform-backend.sh <STORAGE_ACCOUNT_NAME> <RESOURCE_GROUP_NAME> <LOCATION> <OBJECT_ID>
    ```

    For example:

    ```bash
    ./terraform-backend.sh tfstate$RANDOM tfstate northeurope 00000000-0000-0000-0000-000000000000
    ```

    If the backend should not be accessed by a service principal, simply omit the object ID:

    ```bash
    ./terraform-backend.sh tfstate$RANDOM tfstate northeurope
    ```

    If the backend should be accessed by a user or group, it is recommended to manage access using [Azure AD PIM](https://learn.microsoft.com/en-us/azure/active-directory/privileged-identity-management/pim-configure) instead.

## References

- [Store Terraform state in Azure Storage](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli)
- [Security recommendations for Azure Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/security-recommendations)
- [Terraform backend configuration for Azure Storage](https://www.terraform.io/language/settings/backends/azurerm)
