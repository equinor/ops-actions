# Terraform backend script

This directory contains a script `terraform-backend.sh` that will create an Azure Storage account that can be used as a Terraform backend.

It accepts the following arguments:

1. The name of the storage account to create.
1. The name of the Azure resource group to create the storage account in.
1. The Azure region to create the storage account in.
1. (Optional) The object ID of the Azure AD service principal that should be authorized to access the storage account.

## Prerequisites

- [Install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).
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
    ./terraform-backend.sh <STORAGE_ACCOUNT_NAME> <RESOURCE_GROUP_NAME> <LOCATION> [<OBJECT_ID>]
    ```

    For example:

    ```console
    ./terraform-backend.sh tfstate$RANDOM tfstate northeurope 00000000-0000-0000-0000-000000000000
    ```

    If the backend should not be accessed by a service principal, simply omit the object ID:

    ```console
    ./terraform-backend.sh tfstate$RANDOM tfstate northeurope
    ```

## Manage access

Access to the resource group containing the backend should be managed using Azure AD Privileged Identity Management (PIM) and restricted to members of Azure AD group `AZAPPL S<###> - Owner`.

### Assign access

Follow [these steps](https://learn.microsoft.com/en-us/azure/active-directory/privileged-identity-management/pim-resource-roles-assign-roles#assign-a-role) to assign access to the backend using PIM:

| Resource type    | Resource           | Role                      | Member                  |
| ---------------- | ------------------ | ------------------------- | ----------------------- |
| `Resource group` | `<RESOURCE_GROUP>` | `Storage Blob Data Owner` | `AZAPPL S<###> - Owner` |

### Activate access

Members of `AZAPPL S<###> - Owner` can follow [these steps](https://learn.microsoft.com/en-us/azure/active-directory/privileged-identity-management/pim-resource-roles-activate-your-roles#activate-a-role) to activate access to the backend using PIM.

## References

- [Store Terraform state in Azure Storage](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli)
- [Security recommendations for Azure Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/security-recommendations)
- [Terraform backend configuration for Azure Storage](https://www.terraform.io/language/settings/backends/azurerm)
- [Omnia PIM strategy](https://docs.omnia.equinor.com/governance/architecture/Omnia-PIM-Strategy/)
