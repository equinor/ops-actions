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
  $config = ConvertFrom-Json -InputObject $configJson -AsHashtable
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

if ($configRoleAssignments -isnot [Array]) {
  Write-Error -Message "'$roleAssignmentsKey' is not of type 'list'." -ErrorAction Stop
}

# Define which keys are required for each role assignment object
$requiredKeys = @("objectId", "roleDefinitionId", "scope")

foreach ($roleAssignment in $configRoleAssignments) {
  $index = $configRoleAssignments.IndexOf($roleAssignment)

  # Verify that role assignments are objects
  if ($roleAssignment -isnot [Hashtable]) {
    Write-Error -Message "'$roleAssignmentsKey[$index]' is not of type 'object'." -ErrorAction Stop
  }

  # Prepend base scope to configured scope
  $roleAssignment.scope = $baseScope + $roleAssignment.scope

  # Verify that required keys are present and of the expected type
  foreach ($key in $requiredKeys) {
    if (!$roleAssignment.ContainsKey($key)) {
      Write-Error -Message "'$roleAssignmentsKey[$index]' does not contain required key '$key'." -ErrorAction Stop
    }

    if ($roleAssignment[$key] -isnot [String]) {
      Write-Error -Message "'$roleAssignmentsKey[$index].$key' is not of type 'string'." -ErrorAction Stop
    }
  }
}

# Get existing role assignments in Azure
$azRoleAssignments = Get-AzRoleAssignment | Where-Object { $_.scope -match "^$baseScope/*" }

# Compare configuration to Azure
$comparison = Compare-Object -ReferenceObject $configRoleAssignments -DifferenceObject $azRoleAssignments -Property $requiredKeys -IncludeEqual

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
