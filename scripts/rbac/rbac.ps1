param (
  [string]$configFile = "rbac.json"
)

# Read config file
$config = Get-Content $configFile | ConvertFrom-Json -AsHashtable -Depth 3

# Get configured role assignments
$configRoles = $config["roleAssignments"]

# TODO: prepend "/subscriptions/$subscription_id" to value of attribute "scope" for all objects in $configRoles

# Get existing role assignments in Azure
$azureRoles = Get-AzRoleAssignment | Where-Object { $_.scope -match "/subscriptions/*" }

# Compare configuration to Azure
$comparison = Compare-Object -ReferenceObject $configRoles -DifferenceObject $azureRoles -Property ObjectId, RoleDefinitionId, Scope -IncludeEqual

$add = $comparison | Where-Object { $_.SideIndicator -eq "<=" }
$remove = $comparison | Where-Object { $_.SideIndicator -eq "=>" }
$update = $comparison | Where-Object { $_.SideIndicator -eq "==" }

foreach ($a in $add) {
  Write-Host "Creating role assignment: $($a | Out-String)"
}

foreach ($r in $remove) {
  Write-Host "Removing role assignment: $($r | Out-String)"
}

foreach ($u in $update) {
  Write-Host "Updating role assignment: $($u | Out-String)"
}

# TODO: prevent removal of Omnia assignments
