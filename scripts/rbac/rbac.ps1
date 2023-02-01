param (
  [Parameter(Mandatory = $false)]
  [string]$configFile = "rbac.json",

  [Parameter(Mandatory = $false)]
  [string]$baseScope = "/subscriptions/$((Get-AzContext).Subscription.Id)"
)

if (Test-Path -Path $configFile -PathType Leaf) {
  $configJson = Get-Content -Path $configFile -Raw
}
else {
  Write-Error -Message "Configuration file '$configFile' does not exist." -ErrorAction Stop
}

if ($null -eq $configJson) {
  Write-Error "Configuration JSON is empty." -ErrorAction Stop
}

if (Test-Json -Json $configJson -ErrorAction SilentlyContinue) {
  $config = ConvertFrom-Json -InputObject $configJson -AsHashtable -Depth 3
}
else {
  Write-Error -Message "Configuration is not a valid JSON object." -ErrorAction Stop
}

$roleAssignmentsKey = "roleAssignments"
if ($config.ContainsKey($roleAssignmentsKey)) {
  $configRoleAssignments = $config[$roleAssignmentsKey]
}
else {
  Write-Error -Message "Configuration does not contain key '$roleAssignmentsKey'." -ErrorAction Stop
}

# todo: test that role assignments is a list

foreach ($c in $configRoleAssignments) {
  # todo: check for required keys

  # Prepend base scope to configured scopes
  $c.scope = $baseScope + $c.scope
}

# Get existing role assignments in Azure
$azRoleAssignments = Get-AzRoleAssignment | Where-Object { $_.scope -match "^$baseScope/*" }

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
