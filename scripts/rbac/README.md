# RBAC

PowerShell script which manages RBAC assignments at a given parent scope all of its child scopes.

## Prerequisites

- Azure PowerShell: `Install-Module Az`

## Usage

```powershell
./rbac.ps1 -configFile "rbac.json" -parentScope "/subscriptions/<SUBSCRIPTION_ID>"
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

## TODO

- [ ] Add role assignments
- [ ] Update role assignments
- [ ] Remove role assignments

## Notes

| In config | In Azure | Action |
| --------- | -------- | ------ |
| Yes       | No       | Create |
| No        | Yes      | Delete |
| Yes       | Yes      | Update |

- Support for:
  - Role assignments (create and delete by default, see above table)
  - Future: Locks (create by default)

get role assignments creating a test config:

```powershell
Get-AzRoleAssignment | Where-Object {$_.scope -match "/subscriptions/*"} | Select-Object -Property ObjectId, RoleDefinitionId, Scope, Description | ConvertTo-Json | Out-File "roleAssignments.json"
```
