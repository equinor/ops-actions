# OpenID Connect

This directory contains a shell script `oidc.sh` that will configure OpenID Connect (OIDC) to connect from GitHub Actions to Azure, without the need to store the Azure credentials as long-lived GitHub secrets.

It will:

1. Create an Azure AD application
1. Create a federated credential for the Azure AD application
1. Create a service principal for the Azure AD application
1. Create Azure role assignments for the service principal
1. Create GitHub secrets `AZURE_CLIENT_ID`, `AZURE_SUBSCRIPTION_ID` and `AZURE_TENANT_ID`

The script accepts the following arguments:

1. The name of the Azure AD application to create
1. The name or ID of the Azure subscription to configure OIDC for
1. The GitHub repository to configure OIDC for
1. (Optional) The GitHub environment to configure OIDC for
1. The path of the JSON file containing the OIDC configuration

## Prerequisites

- [Install WSL](https://learn.microsoft.com/en-us/windows/wsl/install) - to run shell script
- [Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) - to create Azure AD application, federated credential, service principal and Azure role assignments
- [Install GitHub CLI](https://cli.github.com) - to create GitHub secrets
- [Install jq](https://stedolan.github.io/jq/download/) - to parse JSON config file
- Activate Azure AD role `Application Developer` - to create Azure AD application, federated credential and service principal
- Activate Azure role `Owner` at the subscription scope - to create Azure role assignments
- GitHub repository role `Admin` - to create GitHub environment secrets

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

1. Configure federated credential and role assignments in `oidc.json`.

1. Run the script `oidc.sh`:

    ```console
    ./oidc.sh {APP_NAME} {REPO} {ENVIRONMENT} {CONFIG_FILE}
    ```

    > **Note:** `SUBSCRIPTION_ID`, `REPO` and `ENVIRONMENT` are available as environment variables in `CONFIG_FILE`.

    For example:

    ```console
    ./oidc.sh my-app equinor/ops-actions development ./oidc.json
    ```

    To create the secrets at the repository level, pass an empty string `""` to argument `ENVIRONMENT` .

## References

- [Microsoft Docs](https://docs.microsoft.com/en-us/azure/developer/github/connect-from-azure)
- [GitHub Docs](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure)
