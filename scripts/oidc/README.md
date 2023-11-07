# OpenID Connect

This directory contains a Bash script `oidc.sh` that will configure OpenID Connect (OIDC) to connect from GitHub Actions to Azure, without the need to store the Azure credentials as long-lived GitHub secrets.

It will:

1. Create an Azure AD application
1. Create a service principal for the Azure AD application
1. Create federated credentials for the Azure AD application
1. Create Azure role assignments for the service principal
1. Set GitHub secrets `AZURE_CLIENT_ID`, `AZURE_SUBSCRIPTION_ID` and `AZURE_TENANT_ID`

The script accepts the following arguments:

1. The path of the JSON file containing the OIDC configuration

The script outputs the following values:

1. The object ID of the created service principal.

## Configuration specification

Example configuration:

```json
{
  "appName": "my-app",
  "federatedCredentials": [
    {
      "name": "deploy-dev",
      "subject": "repo:${REPO}:environment:dev",
      "description": "Deploy to dev environment"
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

> **Note**
>
> `appName:` should follow the [App Registration naming convention](https://urban-waffle-59ea765a.pages.github.io/azure/active-directory/app-registrations/).
>
> `.federatedCredentials[].subject` must start with `repo:${REPO}:`.
>
> `.roleAssignments[].scope` must start with `/subscriptions/${SUBSCRIPTION_ID}`.

## Prerequisites

- [Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) (latest version as of writing: `2.49.0`) - to create Azure AD application, federated credentials, service principal and Azure role assignments
- [Install GitHub CLI](https://cli.github.com) (latest version as of writing: `2.30.0`) - to set GitHub secrets
- [Install jq](https://stedolan.github.io/jq/download/) (latest version as of writing: `1.6`) - to parse JSON config file
- Activate Azure AD role `Application Developer` - to create Azure AD application, federated credentials and service principal
  > **Note:** Not necessary when updating the existing config.
- Activate Azure role `Owner` - to create Azure role assignments
  > **Note:** Minimum scope required is what's defined for role assignment in the `oidc.json` config.
- GitHub repository role `Admin` - to set GitHub environment secrets
- If a federated credential is configured with subject `repo:${REPO}:environment:<environment>`, create GitHub environment `<environment>` and set appropriate deployment protection rules.

## Usage

> **Note**
> The script must be run from the GitHub repository to configure OIDC for.

1. Open Bash.

1. Login to Azure:

    ```console
    az login
    ```

1. Set Azure subscription:

    ```console
    az account set -s {SUBSCRIPTION_NAME_OR_ID}
    ```

1. Login to GitHub:

    ```console
    gh auth login
    ```

1. Configure application name, federated credentials and role assignments in a file `oidc.json`.

1. Run the script `oidc.sh`:

    ```console
    ./oidc.sh {CONFIG_FILE}
    ```

    For example:

    ```console
    ./oidc.sh oidc.json
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

## References

- [Microsoft Docs](https://docs.microsoft.com/en-us/azure/developer/github/connect-from-azure)
- [GitHub Docs](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure)
