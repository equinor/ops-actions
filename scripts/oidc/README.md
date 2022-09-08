# OpenID Connect

This directory contains a script `oidc.sh` that will configure OpenID Connect (OIDC) to connect from GitHub Actions to Azure, without the need to store the Azure credentials as long-lived GitHub secrets.

The script accepts the following arguments:

1. The name of the Azure AD application to create
1. The ID of the Azure subscription to configure OIDC for
1. The GitHub repository to configure OIDC for
1. The GitHub environment to configure OIDC for
1. The path of the JSON file containing the OIDC configuration

It will:

1. Create an Azure AD application
1. Create a federated credential for the Azure AD application
1. Create a service principal for the Azure AD application
1. Create an Azure role assignment for the service principal
1. Create GitHub environment secrets `AZURE_CLIENT_ID`, `AZURE_SUBSCRIPTION_ID` and `AZURE_TENANT_ID`

The federated credential and role assignment are configured in `oidc.json`.

## Prerequisites

- [Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) - to create Azure AD application, federated credential, service principal and Azure role assignment
- [Install GitHub CLI](https://cli.github.com) - to create GitHub environment secrets
- [Install jq](https://stedolan.github.io/jq/download/) - to parse JSON config file
- Activate Azure AD role `Application Developer` - to create Azure AD application, federated credential and service principal
- Activate Azure role `Owner` at the subscription scope - to create Azure role assignment
- Login to Azure `az login`

## Usage

1. Configure federated credential and role assignment in `oidc.json`.

1. Run the script `oidc.sh`:

    ```bash
    ./oidc.sh {APP_NAME} {SUBSCRIPTION_ID} {REPO} {ENVIRONMENT} {CONFIG_FILE}
    ```

    For example:

    ```bash
    ./oidc.sh my-app 2e532de1-2fb2-4bd3-9700-bd3364e57ddf equinor/ops-actions development ./oidc.json
    ```

## References

- [Microsoft Docs](https://docs.microsoft.com/en-us/azure/developer/github/connect-from-azure)
- [GitHub Docs](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure)
