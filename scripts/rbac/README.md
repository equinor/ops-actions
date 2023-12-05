# RBAC

PowerShell script which checks RBAC assignments for a given subscription.

## Prerequisites

- Azure PowerShell: `Install-Module Az`

## Usage

1. Open PowerShell.

1. Login to Azure:

    ```powershell
    Connect-AzAccount
    ```

1. Set active Azure subscription:

    ```powershell
    Set-AzContext -Subscription "<SUBSCRIPTION_NAME_OR_ID>"
    ```

1. Configure role assignments in a file `rbac.json`.

1. Run script `rbac.ps1`:

    ```powershell
    ./rbac.ps1 -configFile "rbac.json"
    ```

## Config spec

As defined in `rbac.schema.json`:

```json
{
  "roleAssignments": [
    {
      "objectId": "string",
      "roleDefinitionId": "string",
      "childScope": "optional string",
      "description": "optional string"
    }
  ]
}
```

Example config:

```json
{
  "roleAssignments": [
    {
      "objectId": "00000000-0000-0000-0000-000000000000",
      "roleDefinitionId": "00000000-0000-0000-0000-000000000000",
      "description": "An example role assignment at the subscription scope.",
      "scope": "/subscriptions/<SUBSCRIPTION_ID>"
    },
    {
      "objectId": "00000000-0000-0000-0000-000000000000",
      "roleDefinitionId": "00000000-0000-0000-0000-000000000000",
      "scope": "/subscriptions/<SUBSCRIPTION_ID>/resourceGroups/example-rg",
      "description": "An example role assignment at the resource group scope."
    }
  ]
}
```

## Features

- [ ] Create role assignments
- [ ] Update role assignments
- [ ] Remove role assignments
- [ ] Create PIM assignments
- [ ] Remove PIM assignments
- [ ] Create locks
- [ ] Remove locks
