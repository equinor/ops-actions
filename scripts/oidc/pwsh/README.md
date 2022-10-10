# OpenID Connect PowerShell

This directory contains a PowerShell Module `oidc.psm1` with a function called `New-GitHubConnectionOIDC` that will configure OpenID Connect (OIDC) to connect from GitHub Actions to Azure, without the need to store the Azure credentials as long-lived GitHub secrets.

It will:

1. Create an Azure AD application
1. Create a Federated Identity Credential for the Azure AD application
1. Create a service principal for the Azure AD application
1. Create Azure role assignments for the service principal
1. Create GitHub environment secrets `AZURE_CLIENT_ID`, `AZURE_SUBSCRIPTION_ID` and `AZURE_TENANT_ID`

The script accepts the following arguments:

1. The name of the Azure AD application to create
1. The ID of the Azure subscription to configure OIDC for
1. The GitHub repository to configure OIDC for
1. The GitHub environment to configure OIDC for
1. The path of the JSON file containing the OIDC configuration
1. The Federated Identity Credential Name for the OIDC

## Prerequisites

- [Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) - to create Azure AD application, federated credential, service principal and Azure role assignments
- [Install GitHub CLI](https://cli.github.com) - to create GitHub environment secrets
- Activate Azure AD role `Application Developer` - to create Azure AD application, federated credential and service principal
- Activate Azure role `Owner` at the subscription scope - to create Azure role assignments
- Login to Azure `az login`

## What the Function does

1. Get the Tenant ID from current Azure Subscription Context
2. Load the Configuration file with Resource Groups and RBAC Roles
3. Check if App Registration exists
   1. If if does not exist, it will be created
   2. If it exist, it will store the ClientId as a variable to be used later
4. Create the OIDC JSON file and store it to designated location
5. Check if App Registration has a Federated Identity Credential
   1. If it does not exist, it will be created based on the OIDC JSON file
   2. If it exist, it will be updated based on the OIDC JSON file
6. Check if App Registration has a Service Principal (Enterprise Application)
   1. If it does not exist, it will be created
   2. If it exist, it will store the ObjectId as a variable to be used with RBAC later
7. Check if current Subscription Context matches Subscription provided as input
   1. Function will exit if it does not match
8. Check which RBAC Scope is defined, Resource Group, Resource or Subscription Level
   1. Check if Resource Groups in Config file has match for RBAC Role defined
      1. If it does not exist, it will be added
      2. If it exist, it will skip
   2. Check if Resource match for RBAC Role defined
      1. If it does not exist, it will be added
      2. If it exist, it will skip
   3. Check if Subscription in has match for RBAC Role defined
      1. If it does not exist, it will be added
      2. If it exist, it will skip
9. Create GitHub Environment where Secrets will be stored
10. Create GitHub Secrets

## Usage

1. Copy the PowerShell module and config file to your own Repository.

1. Configure RBAC Role and Resource Groups for role assignments in `oidc-config.json`.

1. Import the PowerShell Module

    ```powershell
    Import-Module ".\src\config\oidc\oidc.psm1" -Force
    ```

1. Populate your variables and run the Function:

    ```powershell
    # Resource Group Level Example
    $AppRegistrationName = "APP_REGISTRATION_NAME"
    $OidcPath            = ".\src\config\oidc"
    $ConfigFile          = "$OidcPath\oidc-config.json"
    $Environment         = "non-prod"
    $FicName             = "github-actions"
    $RbacScope           = "resourceGroup"
    $Repository          = "equinor/your-repository"
    $SubscriptionId      = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

    New-GitHubConnectionOIDC `
        -AppRegistrationName $AppRegistrationName `
        -ConfigFile $ConfigFile `
        -Environment $Environment `
        -FicName $FicName `
        -OidcPath $OidcPath `
        -RbacScope $RbacScope `
        -Repository $Repository `
        -SubscriptionId $SubscriptionId
    ```

    ```powershell
    # Subscription Level Example
    $AppRegistrationName = "APP_REGISTRATION_NAME"
    $OidcPath            = ".\src\config\oidc"
    $ConfigFile          = "$OidcPath\oidc-config.json"
    $Environment         = "non-prod"
    $FicName             = "github-actions"
    $RbacScope           = "subscription"
    $Repository          = "equinor/your-repository"
    $SubscriptionId      = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

    New-GitHubConnectionOIDC `
        -AppRegistrationName $AppRegistrationName `
        -ConfigFile $ConfigFile `
        -Environment $Environment `
        -FicName $FicName `
        -OidcPath $OidcPath `
        -RbacScope $RbacScope `
        -Repository $Repository `
        -SubscriptionId $SubscriptionId
    ```

    ```powershell
    # Invdividual Resource Example
    $AppRegistrationName = "APP_REGISTRATION_NAME"
    $OidcPath            = ".\src\config\oidc"
    $ConfigFile          = "$OidcPath\oidc-config.json"
    $Environment         = "non-prod"
    $FicName             = "github-actions"
    $RbacScope           = "resourceGroup"
    $Repository          = "equinor/your-repository"
    $ResourceRbacRole    = "Key Vault Contributor"
    $ResourceName        = "kv-demo-dev"
    $ResourceType        = "Microsoft.KeyVault/vaults"
    $SubscriptionId      = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

    New-GitHubConnectionOIDC `
        -AppRegistrationName $AppRegistrationName `
        -ConfigFile $ConfigFile `
        -Environment $Environment `
        -FicName $FicName `
        -OidcPath $OidcPath `
        -ResourceRbacRole $ResourceRbacRole `
        -RbacScope $RbacScope `
        -ResourceName $ResourceName `
        -ResourceType $ResourceType `
        -Repository $Repository `
        -SubscriptionId $SubscriptionId
    ```

## References

- [Microsoft Docs](https://docs.microsoft.com/en-us/azure/developer/github/connect-from-azure)
- [GitHub Docs](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure)
