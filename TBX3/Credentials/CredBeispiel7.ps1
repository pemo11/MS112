<#
 .SYNOPSIS
 Start einer Anwendung mit anderen Credentials
 .NOTES
 PSCredential-Objekt aus Textdatei einlesen
 Es gibt zwei User: psuser und psadmin als Administrator mit demo+1234/demo+123 als Kennwort
#>

$AppName = "powershell.exe"
$AppArgs = "-noprofile -noexit -C Get-Process | Where-Object WS -gt 100MB | Select-Object Name,WS,StartTime;whoami"

$CredPath = Join-Path -Path $PSScriptRoot -ChildPath "PSCred.xml"
# Nur einmal erforderlich
# $PwSec = Read-Host -Prompt "Kennwort" -AsSecureString
# $PSCred = [PSCredential]::new("psadmin", $PWSec)
# $PSCred | Export-CliXml -Path $CredPath 

$PSCred = Import-CliXml -Path $CredPath

# Kennwort spielt bei Start-Process offenbar keine Rolle?
# $PSCred = [PSCredential]::new("psadmin", $Null)

# Start einer Anwendung mit anderen Credentials
Start-Process -FilePath $Appname -ArgumentList $AppArgs -Credential $PSCred