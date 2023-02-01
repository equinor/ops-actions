# RBAC

## Prerequisites

- Azure PowerShell: `Install-Module Az`

## Config spec

```json
{
  "roleAssignments": [
    {
      "objectId": "string",
      "roleDefinitionId": "string",
      "scope": "string", // optional; defaults to baseScope
      "description": "string" // optional
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
