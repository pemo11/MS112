<#
 .SYNOPSIS
 Start einer Anwendung als Administrator per RunAs
#>

$AppName = "powershell.exe"
$AppArgs = "-noprofile -noexit -c Get-Process | Where-Object WS -gt 100MB | Select-Object Name,WS,StartTime"

# Start einer Admin-PowerShell - Anmeldung ist nur über einen Anmeldedialog möglich
Start-Process -FilePath $Appname -ArgumentList $AppArgs -Verb RunAs