# OpenID Connect

This directory contains a Bash script `oidc.sh` that will configure OpenID Connect (OIDC) to connect from GitHub Actions to Azure, without the need to store the Azure credentials as long-lived GitHub secrets.

It will:

1. Create an Azure AD application
1. Create federated credentials for the Azure AD application
1. Create a service principal for the Azure AD application
1. Create Azure role assignments for the service principal
1. Set GitHub secrets `AZURE_CLIENT_ID`, `AZURE_SUBSCRIPTION_ID` and `AZURE_TENANT_ID`

## Configuration specification

Example configuration:

```json
{
  "appName": "my-app",
  "federatedCredentials": [
    {
      "name": "deploy-dev",
      "subject": "repo:my-org/my-repo:environment:dev",
      "description": "Deploy to dev environment"
    }
  ],
  "roleAssignments": [
    {
      "scope": "/subscriptions/00000000-0000-0000-0000-000000000000",
      "role": "Contributor"
    }
  ]
}
```

## Prerequisites

- [Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) (latest version as of writing: `2.49.0`) - to create Azure AD application, federated credentials, service principal and Azure role assignments
- [Install GitHub CLI](https://cli.github.com) (latest version as of writing: `2.30.0`) - to set GitHub secrets
- [Install jq](https://stedolan.github.io/jq/download/) (latest version as of writing: `1.6`) - to parse JSON config file
- Activate Azure AD role `Application Developer` - to create Azure AD application, federated credentials and service principal
- Activate Azure role `Owner` - to create Azure role assignments
- GitHub repository role `Admin` - to set GitHub secrets

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

1. Configure federated credentials and role assignments in a file `oidc.json`.

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
