<#
 .SYNOPSIS
 Start einer Anwendung mit anderen Credentials
 .NOTES
 PSCredential über das SecretManagement-Modul abrufen
#>

#requires -Modules Microsoft.PowerShell.SecretManagement

$AppName = "powershell.exe"
$AppArgs = "-noprofile -noexit -c Get-Process | Where-Object WS -gt 100MB | Select-Object Name,WS,StartTime;whoami"

# Abrufen des PSCredentials
$PSCred = Get-Secret -Name AppStart

# Start einer Anwendung mit anderen Credentials (aber ohne Administrator-Berechtigung!)
Start-Process -FilePath $Appname -ArgumentList $AppArgs -Credential $PSCred
