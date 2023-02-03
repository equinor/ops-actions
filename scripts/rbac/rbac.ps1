param (
  [Parameter(Mandatory = $true)]
  [string]$configFile,

  [Parameter(Mandatory = $true)]
  [string]$parentScope
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
  $config = ConvertFrom-Json -InputObject $configJson -AsHashtable
}
else {
  throw "Configuration JSON is invalid: $($JsonError[0].ToString())"
}

$configRoleAssignments = $config["roleAssignments"]

foreach ($roleAssignment in $configRoleAssignments) {
  # Prepend parent scope to configured scope
  $roleAssignment.scope = $parentScope + $roleAssignment.childScope
}

# Get existing role assignments in Azure
$azRoleAssignments = Get-AzRoleAssignment -Scope $parentScope | Where-Object { $_.scope -match "^$parentScope/*" }

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
