# RBAC

## Prerequisites

- Set environment variable `AZURE_SUBSCRIPTION_ID`
- Login to Azure `az login`

## Supported syntax

## Notes

| In config | In Azure | Action |
| --------- | -------- | ------ |
| Yes       | No       | Create |
| No        | Yes      | Delete |
| Yes       | Yes      | Update |

- Support for:
  - Role assignments (create and delete by default, see above table)
  - Future: Locks (create by default)

## Config spec

```yaml
roleAssignments:
  - principalId: string
    scope: string
    roleDefinitionName: string # Optional. Required if "roleDefinitionId" is not set.
    roleDefinitionId: string # Optional. Required if "roleDefinitionName" is not set.
    description: string # Optional
```

`principalId` supports the following formats:

- objectId
- TODO: @resource(id)
- TODO: @user(upn)
- TODO: @group(displayName)
- TODO: @servicePrincipal(???)
