param (
  [Parameter(Mandatory = $false)]
  [string]$configFile = "rbac.json",

  [Parameter(Mandatory = $false)]
  [string]$baseScope = "/subscriptions/$((Get-AzContext).Subscription.Id)"
)

# Read config file
if (Test-Path -Path $configFile -PathType Leaf) {
  $config = Get-Content $configFile | ConvertFrom-Json -AsHashtable -Depth 3
}
else {
  Write-Error -Message "Config file '$configFile' does not exist." -ErrorAction Stop
}

# Get configured role assignments
$roleAssignmentsKey = "roleAssignments"
if ($config.ContainsKey($roleAssignmentsKey)) {
  $configRoleAssignments = $config[$roleAssignmentsKey]
}
else {
  Write-Error -Message "Config file does not contain key '$roleAssignmentsKey'" -ErrorAction Stop
}

# Prepend base scope to configured scopes
foreach ($c in $configRoleAssignments) {
  $scope = $baseScope + $c.scope
  $c.scope = $scope
}

# Get existing role assignments in Azure
$azRoleAssignments = Get-AzRoleAssignment | Where-Object { $_.scope -match "$baseScope/*" }

# Compare configuration to Azure
$comparison = Compare-Object -ReferenceObject $configRoleAssignments -DifferenceObject $azRoleAssignments -Property objectId, roleDefinitionId, scope -IncludeEqual

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
