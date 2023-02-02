# RBAC

PowerShell script which manages RBAC assignments at a given parent scope all of its child scopes.

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
    $context = Set-AzContext -Subscription "<SUBSCRIPTION_NAME_OR_ID>"
    ```

1. Configure role assignments in a file `rbac.json`.

1. Run script `rbac.ps1`:

    ```powershell
    ./rbac.ps1 -configFile "rbac.json" -parentScope "/subscriptions/$($context.Subscription.Id)"
    ```

## Config spec

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

The scope of a configured role assignment is constructed based on the input `parentScope` and the configured `childScope`:

```text
scope = parentScope + childScope
```

Example config where `parentScope` is `/subscriptions/00000000-0000-0000-0000-000000000000`:

```json
{
  "roleAssignments": [
    {
      "objectId": "00000000-0000-0000-0000-000000000000",
      "roleDefinitionId": "00000000-0000-0000-0000-000000000000",
      "description": "An example role assignment at the subscription scope."
    },
    {
      "objectId": "00000000-0000-0000-0000-000000000000",
      "roleDefinitionId": "00000000-0000-0000-0000-000000000000",
      "childScope": "/resourceGroups/example-rg",
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
