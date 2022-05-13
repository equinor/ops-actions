<#
  .LINK
  Password complexity policy: https://docs.microsoft.com/en-us/sql/relational-databases/security/password-policy#password-complexity
#>

param (
  [Parameter(Mandatory = $true)]
  [string]$ServerName,

  [Parameter(Mandatory = $true)]
  [string]$ResourceGroupName,

  [Parameter(Mandatory = $true)]
  [string]$VaultName,

  [Parameter(Mandatory = $true)]
  [string]$SecretName
)

Write-Information 'Generating random password.'
$Length = 128
$Lower = 'a'..'z'
$Upper = 'A'..'Z'
$Digit = '0'..'9'
$Symbol = @('!', '$', '#', '%')
$Characters = $Lower + $Upper + $Digit + $Symbol
do {
  $Password = ''
  for ($i = 0; $i -lt $Length; $i++) {
    $Password += $Characters | Get-Random
  }
  $HasLower = $Password -cmatch '[a-z]'
  $HasUpper = $Password -cmatch '[A-Z]'
  $HasDigit = $Password -match '[0-9]'
}
until ($HasLower -and $HasUpper -and $HasDigit)
$Password = $Password | ConvertTo-SecureString -AsPlainText -Force

Write-Information "Updating SQL server '$ServerName' admin password."
$null = Set-AzSqlServer -ServerName $ServerName -ResourceGroupName $ResourceGroupName -SqlAdministratorPassword $Password

$KeyVaultFirewall = (Get-AzKeyVault -VaultName $VaultName).NetworkAcls
$KeyVaultFirewallRules = $KeyVaultFirewall.IpAddressRanges
$KeyVaultFirewallEnabled = $KeyVaultFirewall.DefaultAction -eq 'Deny'
Write-Information "Key vault '$VaultName' firewall enabled: $KeyVaultFirewallEnabled."

try {
  if ($KeyVaultFirewallEnabled) {
    $PublicIp = "$((Invoke-WebRequest -uri 'http://ifconfig.me/ip').Content)/32"
    $KeyVaultFirewallContainsIp = $KeyVaultFirewallRules -contains $PublicIp
    Write-Information "Key vault firewall rules contain public IP '$PublicIp': $KeyVaultFirewallContainsIp."

    if (!$KeyVaultFirewallContainsIp) {
      Write-Information 'Adding public IP to key vault firewall rules.'
      $null = Update-AzKeyVaultNetworkRuleSet -VaultName $VaultName -IpAddressRange ($KeyVaultFirewallRules + $PublicIp)
    }
  }

  Write-Information "Updating key vault secret '$SecretName' value."
  $SecretExpires = (Get-Date).AddYears(1)
  $Secret = Set-AzKeyVaultSecret -Name $SecretName -VaultName $VaultName -SecretValue $Password -ContentType 'password' -Expires $SecretExpires
  $Secret

  Write-Information "Disabling old key vault secret versions."
  $SecretVersions = (Get-AzKeyVaultSecret -Name $SecretName -VaultName $VaultName -IncludeVersions | Where-Object { $_.Enabled }).Version
  foreach ($v in $SecretVersions) {
    if ($v -ne $Secret.Version) {
      $null = Update-AzKeyVaultSecret -Name $SecretName -VaultName $VaultName -Version $v -Enable $false
    }
  }
}
catch {
  Write-Error $_.Exception
}
finally {
  if (!$KeyVaultFirewallContainsIp) {
    Write-Information 'Restoring key vault firewall rules.'
    $null = Update-AzKeyVaultNetworkRuleSet -VaultName $VaultName -IpAddressRange $KeyVaultFirewallRules
  }
}
