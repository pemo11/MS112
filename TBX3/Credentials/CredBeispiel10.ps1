<#
 .SYNOPSIS
 Start einer Anwendung mit anderen Credentials
 .NOTES
 PSCredential über das SecretManagement-Modul speichern
#>

#requires -Modules Microsoft.PowerShell.SecretManagement

$PwSec = Read-Host -Prompt "Kennwort?" -AsSecureString
$PSCred = [PSCredential]::new("psadmin", $PWSec)

Set-Secret -Name AppStart -Secret $PSCred -Vault BuiltInLocalVault

# Schritt 3: Secret abrufen
Get-Secret -Name AppStart

