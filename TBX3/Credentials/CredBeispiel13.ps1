<#
 .SYNOPSIS
 Secrets mit Metadaten anlegen
#>

#requires -Modules Microsoft.PowerShell.SecretManagement

# Anlegen eines neuen Secrets mit Metadaten
$PwSec = Read-Host -Prompt "Kennwort?" -AsSecureString
$PSCred = [PSCredential]::new("psadmin", $PWSec)
$Meta = @{ "Name" = "psadmin"; "Description" = "Administrator-Kennwort"; "Tags" = "psadmin,admin"; "Notes" = "Das ist ein Test" }
Set-Secret -Name AppStart -Secret $PSCred -Metadata $Meta -Vault TestVault

# Schritt 3: Secret-Info abrufen
Get-SecretInfo -Name AppStart | Select-Object *
