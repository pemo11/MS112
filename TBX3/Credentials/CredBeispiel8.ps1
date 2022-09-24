<#
 .SYNOPSIS
 Start einer Anwendung mit anderen Credentials
 .NOTES
 SecureString über das SecretManagement-Modul abspeichern
#>

#requires -Modules Microsoft.PowerShell.SecretManagement

# Schritt 1: Abrufen des eingebauten BuiltInLocalVault
Get-SecretVault

# Schritt 2: Ein SecureString als Secret anlegen
$PwSec = Read-Host -Prompt "Kennwort?" -AsSecureString
Set-Secret -Name AppStart -SecureStringSecret $PwSec -Vault BuiltInLocalVault

# Schritt 3: Secret SecureString abrufen
Get-Secret -Name AppStart

# Das geht nach wie vor
Get-Secret -Name AppStart | ConvertFrom-SecureString

# Und das auch
$Pw = Get-Secret -Name AppStart
[PSCredential]::New("test", $Pw).GetNetworkCredential().Password