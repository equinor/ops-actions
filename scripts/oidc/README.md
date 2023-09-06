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
> `.federatedCredentials[].subject` must start with `repo:${REPO}:`.
>
> `.roleAssignments[].scope` must start with `/subscriptions/${SUBSCRIPTION_ID}`.

## Prerequisites

- [Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) (latest version as of writing: `2.49.0`) - to create Azure AD application, federated credentials, service principal and Azure role assignments
- [Install GitHub CLI](https://cli.github.com) (latest version as of writing: `2.30.0`) - to set GitHub secrets
- [Install jq](https://stedolan.github.io/jq/download/) (latest version as of writing: `1.6`) - to parse JSON config file
- Activate Azure AD role `Application Developer` - to create Azure AD application, federated credentials and service principal
- Activate Azure role `Owner` - to create Azure role assignments
- GitHub repository role `Admin` - to set GitHub secrets

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

## References

- [Microsoft Docs](https://docs.microsoft.com/en-us/azure/developer/github/connect-from-azure)
- [GitHub Docs](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure)
