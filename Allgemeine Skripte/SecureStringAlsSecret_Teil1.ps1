<#
 .Synopsis
 Kennwort per SecretManagement Modul abspeichern
#>

#requires -modules Microsoft.PowerShell.SecretManagement
#requires -modules Microsoft.PowerShell.SecretStore

Register-SecretVault -Name SecretStore -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault
$PwSec = Read-Host -Prompt "Pw?" -AsSecureString
Beim ersten Mal ist eine Passwort-Eingabe für den Vault erforderlich (demo+123)
Set-Secret -Name PwSec -Secret $PwSec -Vault SecretStore 

Get-SecretVault -Name SecretStore 

Test-SecretVault -Name SecretStore