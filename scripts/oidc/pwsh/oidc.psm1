function New-GitHubConnectionOIDC {
    <#
        .DESCRIPTION
        Create a new Connection between Azure and GitHub using Service Principal and OIDC.
        .PARAMETER AppRegistrationName
        Name of the App Registration in Azure AD.
        .PARAMETER ConfigFile
        Location for Config File.
        .PARAMETER Environment
        Environment in GitHub (e.g. non-prod, prod).
        .PARAMETER FicName
        Name of Federated Identity Credential.
        .PARAMETER OidcPath
        Custom Path to store the OIDC Config.
        .PARAMETER RbacScope
        Scope for RBAC Roles (resourceGroup, resource or subscription level).
        .PARAMETER Repository
        Name of GitHub Repository (Optional).
        .PARAMETER ResourceRbacRole
        RBAC Role for individual resource (Optional).
        .PARAMETER ResourceName
        Name of individual resource for RBAC Scope (Optional).
        .PARAMETER ResourceType
        Resource Type for individual Resource for RBAC Scope (Optional).
        .PARAMETER SubscriptionId
        Subscription ID (GUID).
        .EXAMPLE
        # Import Module
        Import-Module ".\src\config\oidc\oidc.psm1" -Force

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
    #>
    [CmdletBinding(
        SupportsShouldProcess = $True,
        ConfirmImpact = "Low"
    )]
    param (
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
        [ValidateSet("resourceGroup", "subscription", "resource")]
        [String] $RbacScope,
        [Parameter (Mandatory = $true)]
        [String] $Repository,
        [Parameter (Mandatory = $false)]
        [String] $ResourceRbacRole,
        [Parameter (Mandatory = $false)]
        [String] $ResourceName,
        [Parameter (Mandatory = $false)]
        [String] $ResourceType,
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

        function Set-RbacRole {
            [CmdletBinding(
                SupportsShouldProcess = $True,
                ConfirmImpact = "Low"
            )]
            param (
                [Parameter (Mandatory = $true)]
                [String] $RbacRole,
                [Parameter (Mandatory = $true)]
                [String] $Scope,
                [Parameter (Mandatory = $true)]
                [String] $SpObjectId,
                [Parameter (Mandatory = $true)]
                [String] $SubscriptionId
            )
            if ($PSCmdlet.ShouldProcess("RBAC Role '$RbacRole' for Scope '$Scope'")) {
                $roleCheck = az role assignment list --role $rbacRole --scope $scope | ConvertFrom-Json
                if ($roleCheck) {
                    # Get all Role Assignments for Service Principal ObjectId
                    foreach ($role in $roleCheck | Where-Object { $_.principalId -eq $spObjectId }) {
                        # Check if Role Assignment is match for Service Principal ObjectId
                        if (($role.principalId -eq $spObjectId) -and $($role.roleDefinitionName -eq $rbacRole)) {
                            Write-Output "RBAC Role '$rbacRole' already exists for Service Principal '$spObjectId' at scope '$scope'"
                        }
                    }
                }
                elseif (!$roleCheck) {
                    # Assign RBAC Role for Service Principal ObjectId
                    Write-Output "Assigning role '$rbacRole' for Service Principal '$spObjectId' at scope '$scope'..."
                    az role assignment create --role $rbacRole --subscription $SubscriptionId --assignee-object-id $spObjectId `
                        --assignee-principal-type ServicePrincipal --scope $scope --output none
                }
            }
        }

        Write-Output "Checking RBAC Assignment."
        Write-Output "RBAC Assignment is set to '$RbacScope'"
        if ($RbacScope -eq "resourceGroup") {
            Write-Output "Starting RBAC Assignment for Resource Groups"
            Write-Output "Reading config..."

            $config         = Get-Content $ConfigFile | ConvertFrom-Json -AsHashtable
            $rbacRole       = $config.roleAssignments.$RbacScope.$Environment.rbacRole
            $resourceGroups = $config.roleAssignments.$RbacScope.$Environment.resourceGroups

            Write-Output "Checking and creating RBAC Role Assignments..."
            foreach ($resourceGroup in $resourceGroups) {
                try {
                    # Get Resource Group Object
                    $scope = az group show --name $resourceGroup --subscription $SubscriptionId --query id --output tsv
                    # Check Role Assignments for Resource Group Scope
                    Set-RbacRole -RbacRole $rbacRole -Scope $scope -SpObjectId $spObjectId -SubscriptionId $SubscriptionId
                }
                catch {
                    Write-Error $_.Exception
                }
            }
        }
        elseif ($RbacScope -eq "subscription") {
            Write-Output "Starting RBAC Assignment for Subscription"
            Write-Output "Reading config..."

            $config   = Get-Content $ConfigFile | ConvertFrom-Json -AsHashtable
            $rbacRole = $config.roleAssignments.$RbacScope.rbacRole

            try {
                $scope = "/subscriptions/$SubscriptionId"
                Set-RbacRole -RbacRole $rbacRole -Scope $scope -SpObjectId $spObjectId -SubscriptionId $SubscriptionId
            }
            catch {
                Write-Error $_.Exception
            }
        }
        elseif ($RbacScope -eq "resource") {
            Write-Output "Starting RBAC Assignment for individual resource '$ResourceName'"
            try {
                $scope = az resource list --name $ResourceName --resource-type $ResourceType --subscription $SubscriptionId --query [].id --output tsv
                Set-RbacRole -RbacRole $ResourceRbacRole -Scope $scope -SpObjectId $spObjectId -SubscriptionId $SubscriptionId
            }
            catch {
                Write-Error $_.Exception
            }
        }
    }

    Write-Output "Creating GitHub environment..."
    gh api --method PUT "repos/$Repository/environments/$Environment"

    Write-Output "Updating GitHub secrets..."
    gh secret set 'AZURE_CLIENT_ID' --body $spClientId --repo $Repository --env $Environment
    gh secret set 'AZURE_SUBSCRIPTION_ID' --body $SubscriptionId --repo $Repository --env $Environment
    gh secret set 'AZURE_TENANT_ID' --body $tenantId --repo $Repository --env $Environment
}