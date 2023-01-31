param (
  [string]$configFile = "rbac.json"
)

# Read config file
$config = Get-Content $configFile | ConvertFrom-Json -AsHashtable -Depth 3

# Get configured role assignments
$configRoles = $config["roleAssignments"]

# Get existing role assignments in Azure
$azureRoles = Get-AzRoleAssignment | Where-Object {$_.scope -match "/subscriptions/*"}

# Compare configuration to Azure
$comparison = Compare-Object -ReferenceObject $configRoles -DifferenceObject $azureRoles -Property ObjectId, RoleDefinitionId, Scope -IncludeEqual

$add = $comparison | Where-Object {$_.SideIndicator -eq "<="}
$remove = $comparison | Where-Object {$_.SideIndicator -eq "=>"}
$update = $comparison | Where-Object {$_.SideIndicator -eq "=="}

Write-Host "Add: $($add | Out-String)"
Write-Host "Remove: $($remove | Out-String)"
Write-Host "Update: $($update | Out-String)"
