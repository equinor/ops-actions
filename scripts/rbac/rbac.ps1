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

$inConfig = $comparison | Where-Object { $_.SideIndicator -eq "<=" }
$inAzure = $comparison | Where-Object { $_.SideIndicator -eq "=>" }
$inBoth = $comparison | Where-Object { $_.SideIndicator -eq "==" }

foreach ($i in $inConfig) {
  Write-Host "In config: $($i | Out-String)"
}

foreach ($i in $inAzure) {
  Write-Host "In Azure: $($i | Out-String)"
}

foreach ($i in $inBoth) {
  Write-Host "In both: $($i | Out-String)"
}

# TODO: prevent removal of Omnia assignments
