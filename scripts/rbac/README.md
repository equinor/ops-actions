# RBAC

## Prerequisites

- Set environment variable `AZURE_SUBSCRIPTION_ID`
- Login to Azure `az login`

## Supported syntax

- objectId
- TODO: @resource(id)
- TODO: @user(upn)
- TODO: @group(displayName)
- TODO: @servicePrincipal(???)

## Notes

| In config | In Azure | Action |
| --------- | -------- | ------ |
| Yes       | No       | Create |
| No        | Yes      | Delete |
| Yes       | Yes      | Update |

- Support for:
  - Role assignments (create and delete by default, see above table)
  - Future: Locks (create by default)
