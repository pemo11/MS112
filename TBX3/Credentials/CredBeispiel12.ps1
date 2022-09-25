<#
 .SYNOPSIS
 Abfragen von Secrets und Vaults
#>

#requires -Modules Microsoft.PowerShell.SecretManagement

Get-SecretInfo

Get-SecretVault

Get-SecretVault | ForEach-Object {
    Test-SecretVault -Name $_.Name
}
