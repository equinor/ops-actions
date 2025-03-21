# OpenID Connect

This directory contains a Bash script `oidc.sh` that will configure OpenID Connect (OIDC) to connect from GitHub Actions to Azure, without the need to store the Azure credentials as long-lived GitHub secrets.

It will:

1. Create a Microsoft Entra application
1. Create a service principal for the Microsoft Entra application
1. Create federated credentials for the Microsoft Entra application
1. Create Azure role assignments for the service principal
1. Set GitHub secrets `AZURE_CLIENT_ID`, `AZURE_SUBSCRIPTION_ID` and `AZURE_TENANT_ID`

The script accepts the following arguments:

1. The path of the JSON file containing the OIDC configuration
1. (Optional) The GitHub repository to configure OIDC from.
1. (Optional) The ID of the Azure subscription to configure OIDC to.

## Prerequisites

- [Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) - to create Microsoft Entra application, service principal and Azure role assignments.
- [Install GitHub CLI](https://cli.github.com) - to set GitHub secrets.
- [Install jq](https://stedolan.github.io/jq/download/) - to parse JSON configuration file.
- Microsoft Entra role `Application Developer` - to create Microsoft Entra application and service principal.
- Azure role `Owner` - to create Azure role assignments.
- GitHub repository role `Admin` - to set GitHub secrets.

## Configuration

Example configuration:

```json
{
  "appName": "GitHub app",
  "federatedCredentials": [
    {
      "name": "github-federated-identity",
      "subject": "repo:${REPO}:environment:Development",
      "description": "GitHub service principal federated identity"
    }
  ],
  "roleAssignments": [
    {
      "scope": "/subscriptions/${SUBSCRIPTION_ID}",
      "role": "Contributor"
    }
  ]
}
```

> [!Note]
>
> The value of `.federatedCredentials[].subject` should contain the prefix `repo:${REPO}:`.
>
> The value of `.roleAssignments[].scope` should contain the prefix `/subscriptions/${SUBSCRIPTION_ID}`.

## Usage

1. Open Bash.

1. Login to Azure:

   ```console
   az login
   ```

1. Login to GitHub:

   ```console
   gh auth login
   ```

1. Configure application name, federated credentials and role assignments in a file `oidc.json`.

1. Run the script `oidc.sh`:

   ```console
   ./oidc.sh <CONFIG_FILE> [<REPO>] [<SUBSCRIPTION_ID>]
   ```

   For example, configure OIDC from the GitHub repository containing the configuration file to the active Azure subscription:

   ```console
   ./oidc.sh oidc.json
   ```

   Or, configure OIDC from the specified GitHub repository to the specified Azure subscription:

   ```console
   ./oidc.sh oidc.json equinor/ops-actions 034ce851-5375-47b3-8ed2-0a637c9d4141
   ```

### After running the `oidc.sh` script

After the App Registration has been created, by Equinor policy, one or more Application Owners from Equinor needs to be set for the App Registration as well as a CI reference.

The CI reference and the appropriate Application Owners can be found in [ServiceNow's](https://equinor.service-now.com/selfservice?id=cmdb_ci_list&table=cmdb_ci_spkg&spa=1&filter=operational_statusNOT%20IN2,5&p=1) list for IT applications, under the relevant application.

## Updating configuration

Updating the `oidc.json` configuration file requires you to run the `oidc.sh` script again.
Rerunning the script only performs create/update operations, not delete operations.

For example:

- When updating the App Registration name, a new App Registration will be created, and you'll need to manually delete the old one.
- When adding, updating or removing federated credentials in the configuration file, you'll need to manually delete old federated credentials from the App Registration.
- When adding, updating or removing role assignments in the configuration file, you'll need to manually delete old role assignments.

## Troubleshooting

- If running the script in Git Bash, you might encounter the following error message: `InvalidSchema: No connection adapters were found`. To fix this error, set the following environment variable: `export MSYS_NO_PATHCONV=1`.
- if running the script in Git Bash on Windows, you might have problems installing prerequisite `jq`. Open Git Bash as administrator and run following commands:
  ```console
   mkdir -p "${EXEPATH}/usr/local/bin"
   ```
  ```console
   curl -L -o /usr/local/bin/jq.exe \ https://github.com/stedolan/jq/releases/latest/download/jq-win64.exe
   ```

## References

- [Microsoft Docs](https://docs.microsoft.com/en-us/azure/developer/github/connect-from-azure)
- [GitHub Docs](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure)
