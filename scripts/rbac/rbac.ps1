param (
  [Parameter(Mandatory = $true)]
  [string]$configFile
)

if (Test-Path -Path $configFile -PathType Leaf) {
  $configJson = Get-Content -Path $configFile -Raw
}
else {
  throw "Configuration file '$configFile' does not exist."
}

if ($null -eq $configJson) {
  throw "Configuration JSON is empty."
}

$schemaFile = "$PSScriptRoot\rbac.schema.json"
if (Test-Json -Json $configJson -SchemaFile $schemaFile -ErrorAction SilentlyContinue -ErrorVariable JsonError) {
  $config = ConvertFrom-Json -InputObject $configJson
}
else {
  throw "Configuration JSON is invalid: $($JsonError[0].ToString())"
}

$subscriptionId = (Get-AzContext).Subscription.Id
$parentScope = "/subscriptions/$subscriptionId"

$configRoleAssignments = $config.roleAssignments

# Get existing role assignments in Azure
$azRoleAssignments = Get-AzRoleAssignment -Scope $parentScope | Where-Object { $_.scope -match "^$parentScope/*" }

# Compare configuration to Azure
$Properties = "displayName", "objectId", "roleDefinitionName", "roleDefinitionId", "scope"
$comparison = Compare-Object -ReferenceObject $configRoleAssignments -DifferenceObject $azRoleAssignments -Property $properties -IncludeEqual

$inConfig = $comparison | Where-Object { $_.SideIndicator -eq "<=" }
$inAzure = $comparison | Where-Object { $_.SideIndicator -eq "=>" }
# $inBoth = $comparison | Where-Object { $_.SideIndicator -eq "==" }

$newConfig = $configRoleAssignments + $inAzure

@{
  "roleAssignments" = $newConfig | Select-Object -Property $properties
} | ConvertTo-Json -Depth 100 | Set-Content -Path $configFile

"$`{{ SUBSCRIPTION_ID }}" -replace "$subscriptionId"


# Remove role assignments from config that are not in Azure
$currentConfig = (Get-Content .\rbac.json  | ConvertFrom-Json)
$newConfig = @{ roleAssignments = @() }

Foreach ($c in $currentConfig.roleAssignments) {
    if ($inConfig.objectId -contains $c.objectId) {
        Write-Output "Removing item: $($c.objectId)"
    }
    else {
        # Write-Output "Keeping item: $($c.objectId)"
        $newConfig.roleAssignments += $c
    }
}
$newConfig | ConvertTo-Json | Set-Content -Path .\rbac.json -Force
