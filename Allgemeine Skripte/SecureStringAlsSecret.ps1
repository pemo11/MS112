<#
 .Synopsis
 Kennwort per SecretManagement Modul abrufen
#>

#requires -modules Microsoft.PowerShell.SecretManagement
#requires -modules Microsoft.PowerShell.SecretStore

#Register-SecretVault -Name SecretStore -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault
#$PwSec = Read-Host -Prompt "Pw?" -AsSecureString
# Beim ersten Mal ist eine Passwort-Eingabe für den Vault erforderlich (demo+123)
#Set-Secret -Name PwSec -Secret $PwSec -Vault SecretStore

$Username = "qskills"
$PwSec = Get-Secret -Name PwSec
$Cred = [PSCredential]::new($Username, $PwSec)
Invoke-Command -ComputerName ES6101  -Credential $cred -ScriptBlock { hostname }
