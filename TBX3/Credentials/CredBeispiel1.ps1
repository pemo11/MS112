<#
 .SYNOPSIS
 Start einer Anwendung mit anderen Credentials
 .NOTES
 Dieses Mal ohne Credentials
#>

$AppName = "powershell.exe"
$AppArgs = "-noprofile -noexit -c Get-Process | Where-Object WS -gt 100MB | Select-Object Name,WS,StartTime"

Start-Process -FilePath $Appname -ArgumentList $AppArgs