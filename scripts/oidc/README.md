# OpenID Connect

This directory contains a Python script `github-azure-oidc.py` that will configure OpenID Connect (OIDC) to connect from GitHub Actions to Azure, without the need to store the Azure credentials as long-lived GitHub secrets.

It will:

1. Create an Azure AD application
1. Create a service principal for the Azure AD application
1. Create federated credentials for the Azure AD application
1. Create Azure role assignments for the service principal
1. Set GitHub secrets `AZURE_CLIENT_ID`, `AZURE_SUBSCRIPTION_ID` and `AZURE_TENANT_ID`

The script accepts the following arguments:

1. The path of the JSON file containing the OIDC configuration

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
    },
    {
      "scope": "/subscriptions/${SUBSCRIPTION_ID}",
      "role": "Role Based Access Control Administrator",
      "condition": "((!(ActionMatches{'Microsoft.Authorization/roleAssignments/write'})) OR (@Request[Microsoft.Authorization/roleAssignments:RoleDefinitionId] ForAnyOfAllValues:GuidNotEquals {8e3af657-a8ff-443c-a75c-2fe8c4bcb635, 18d7d88d-d35e-4fb5-a5c3-7773c20a72d9, f58310d9-a9f6-439a-9e8d-f62e7b41a168})) AND ((!(ActionMatches{'Microsoft.Authorization/roleAssignments/delete'})) OR (@Resource[Microsoft.Authorization/roleAssignments:RoleDefinitionId] ForAnyOfAllValues:GuidNotEquals {8e3af657-a8ff-443c-a75c-2fe8c4bcb635, 18d7d88d-d35e-4fb5-a5c3-7773c20a72d9, f58310d9-a9f6-439a-9e8d-f62e7b41a168}))"
    }
  ]
}
```

This configuration will instruct the script to create an Azure AD application and a service principal with name `my-app` and a federated credential with name `deploy-dev` that'll allow deployments from the `dev` environment in the GitHub repository.

It'll also assign two Azure roles at the subscription scope to the service principal:

1. `Contributor`
1. `Role Based Access Control Administrator` (with a condition that prevents the service principal from assigning roles `Owner`, `User Access Administrator` and `Role Based Access Control Administrator` to other principals).

> **Note**
>
> `.federatedCredentials[].subject` must start with `repo:${REPO}:`.
>
> `.roleAssignments[].scope` must start with `/subscriptions/${SUBSCRIPTION_ID}`.

## Prerequisites

- [Python](https://www.python.org/downloads/) **version 3.12**
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

## Development

- Create virtual environment:

    ```console
    python -m venv venv
    . venv/Scripts/activate
    ```

- Install requirements:

    ```console
    python -m pip install --upgrade pip
    pip install -r requirements.txt
    ```

## Usage

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

1. Run the script:

    ```console
    python -m github_azure_oidc {CONFIG_FILE}
    ```

    For example:

    ```console
    python -m github_azure_oidc oidc.json
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

## References

- [Microsoft Docs](https://docs.microsoft.com/en-us/azure/developer/github/connect-from-azure)
- [GitHub Docs](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure)
