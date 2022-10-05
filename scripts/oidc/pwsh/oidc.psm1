
function New-GitHubConnectionOIDC {
    <#
        .DESCRIPTION
        Create a new Connection between Azure and GitHub using Service Principal and OIDC.
        .PARAMETER AddRbacRole
        Set to True if RBAC Role and Resource Groups are defined in Config File. Not mandatory.
        .PARAMETER AppRegistrationName
        Name of the App Registration in Azure AD.
        .PARAMETER ConfigFile
        Location for Config File.
        .PARAMETER FicName
        Name of Federated Identity Credential.
        .PARAMETER Environment
        Environment in GitHub (e.g. non-prod, prod).
        .PARAMETER OidcPath
        Custom Path to store the OIDC Config.
        .PARAMETER SubscriptionId
        Subscription ID (GUID).
        .EXAMPLE
        # Import Module
        Import-Module ".\src\config\oidc\oidc.psm1" -Force

        $AddRbacRole         = $True
        $AppRegistrationName = "APP_REGISTRATION_NAME"
        $OidcPath            = ".\src\config\oidc"
        $ConfigFile          = "$OidcPath\oidc-config.json"
        $Environment         = "non-prod"
        $FicName             = "github-actions"
        $Repository          = "equinor/your-repository"
        $SubscriptionId      = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

        New-GitHubConnectionOIDC `
            -AddRbacRole $AddRbacRole `
            -AppRegistrationName $AppRegistrationName `
            -ConfigFile $ConfigFile `
            -Environment $Environment `
            -FicName $FicName `
            -OidcPath $OidcPath `
            -Repository $Repository `
            -SubscriptionId $SubscriptionId
    #>
    [CmdletBinding(
        SupportsShouldProcess = $True,
        ConfirmImpact = "Low"
    )]
    param (
        [Parameter (Mandatory = $false)]
        [Boolean] $AddRbacRole = $false,
        [Parameter (Mandatory = $true)]
        [String] $AppRegistrationName,
        [Parameter (Mandatory = $true)]
        [String] $ConfigFile,
        [Parameter (Mandatory = $true)]
        [String] $Environment,
        [Parameter (Mandatory = $true)]
        [String] $FicName,
        [Parameter (Mandatory = $true)]
        [String] $OidcPath,
        [Parameter (Mandatory = $true)]
        [String] $Repository,
        [Parameter (Mandatory = $true)]
        [String] $SubscriptionId
    )
    if ($PSCmdlet.ShouldProcess("Creating new OIDC Connection '$FicName' for Repository '$Repository'")) {

        Write-Output "Subscription Id: $SubscriptionId"
        $tenantId = az account show --subscription $SubscriptionId --query tenantId --output tsv
        Write-Output "Tenant Id: '$tenantId'"
        Write-Output "Logging into GitHub..."

        gh auth login

        Write-Output 'Checking if application already exists...'

        $spClientId = az ad app list --filter "displayName eq '$AppRegistrationName'" --query [].appId --output tsv
        try {
            if ($null -eq $spClientId) {
                Write-Output 'Creating application...'
                $spClientId = az ad app create --display-name $AppRegistrationName --query appId --output tsv
            }
            else {
                Write-Output "Using existing application."
            }
        }
        catch {
            Write-Error $_.Exception
        }
        finally {
            Write-Output "Client Id: '$spClientId'"
        }

        Write-Output "Creating JSON Object for Federated Identity Credential"
        $jsonObject = [PSCustomObject]@{
            "name"        = "$FicName"
            "issuer"      = "https://token.actions.githubusercontent.com"
            "subject"     = "repo:$($Repository):environment:$($Environment)"
            "description" = "OIDC auth from GitHub Actions to Azure"
            "audiences"   = @(
                "api://AzureADTokenExchange"
            )
        }

        # Create path for JSON file
        $jsonFilePath = "$OidcPath\oidc-$($Environment).json"

        # Save JSON file
        Write-Output "Saving JSON file to '$jsonFilePath'"
        $jsonObject | ConvertTo-Json | Out-File -FilePath $jsonFilePath

        Write-Output "Checking if Federated Credential exists for '$AppRegistrationName'"
        $ficId = az ad app federated-credential list --id $spClientId --query "[?name == '$FicName'].id" --output tsv
        try {
            if ($null -eq $ficId) {
                Write-Output "Creating Federated Identity Credential..."
                az ad app federated-credential create --id $spClientId --parameters $jsonFilePath --output none
            }
            else {
                Write-Output "Updating existing Federated Identity Credential."
                az ad app federated-credential update --id $spClientId --federated-credential-id $ficId --parameters $jsonFilePath --output none
            }
        }
        catch {
            Write-Error $_.Exception
        }

        Write-Output "Checking if Service Principal already exists..."
        $spObjectId = az ad sp list --filter "appId eq '$spClientId'" --query [].id --output tsv
        try {
            if ($null -eq $spObjectId) {
                Write-Output 'Creating Service Principal...'
                $spObjectId = az ad sp create --id $spClientId --query id --output tsv
            }
            else {
                Write-Output "Using existing Service Principal!"
            }
        }
        catch {
            Write-Error $_.Exception
        }
        finally {
            Write-Output "Object Id: $spObjectId"
        }

        Write-Output "Checking Subscription Context"
        try {
            $subContextId = az account show --query id --output tsv
            if ($subContextId -ne $SubscriptionId) {
                Write-Error "Error: Subscription Context mismatch. Exiting!"
                exit 1
            }
            else {
                Write-Output "Subscription Context match. Continuing!"
            }
        }
        catch {
            Write-Error $_.Exception
        }


        Write-Output "Checking if RBAC Assignment is defined"
        # Check if AddRbacRole is specified, read config and assign roles for Resource Groups
        if ($AddRbacRole -eq $true) {
            Write-Output "Adding RBAC Roles"
            Write-Output "Reading config..."

            $config         = Get-Content $ConfigFile | ConvertFrom-Json -AsHashtable
            $rbacRole       = $config.roleAssignments.$Environment.rbacRole
            $resourceGroups = $config.roleAssignments.$Environment.resourceGroups

            Write-Output "Checking and creating RBAC Role Assignments..."
            foreach ($resourceGroup in $resourceGroups) {
                try {
                    # Get Resource Group Object
                    $rg = az group show --name $resourceGroup --subscription $SubscriptionId | ConvertFrom-Json
                    # Check Role Assignments for Resource Group Scope
                    $roleCheck = az role assignment list --role $rbacRole --scope $rg.id | ConvertFrom-Json
                    if ($roleCheck) {
                        # Get all Role Assignments for Service Principal ObjectId
                        foreach ($role in $roleCheck | Where-Object { $_.principalId -eq $spObjectId }) {
                            # Check if Role Assignment is match for Service Principal ObjectId
                            if (($role.principalId -eq $spObjectId) -and $($role.roleDefinitionName -eq $rbacRole)) {
                                Write-Output "RBAC Role '$rbacRole' already exists for Service Principal '$spObjectId' at scope '$($rg.id)'"
                            }
                            else {
                                Write-Output "Nothing to see here"
                            }
                        }
                    }
                    elseif (!$roleCheck) {
                        # Assign RBAC Role to Service Principal ObjectId for Resource Group
                        Write-Output "Assigning role '$rbacRole' for Service Principal '$spObjectId' at scope '$($rg.id)'..."
                        az role assignment create --role $rbacRole --subscription $SubscriptionId --assignee-object-id $spObjectId `
                            --assignee-principal-type ServicePrincipal --scope $rg.id --output none
                    }
                }
                catch {
                    Write-Error $_.Exception
                }
            }
        }
        else {
            Write-Output "No RBAC Assignment defined. Continuing!"
        }

        Write-Output "Creating GitHub environment..."
        gh api --method PUT "repos/$Repository/environments/$Environment"

        Write-Output "Updating GitHub secrets..."
        gh secret set 'AZURE_CLIENT_ID' --body $spClientId --repo $Repository --env $Environment
        gh secret set 'AZURE_SUBSCRIPTION_ID' --body $SubscriptionId --repo $Repository --env $Environment
        gh secret set 'AZURE_TENANT_ID' --body $tenantId --repo $Repository --env $Environment
    }
}