<#
 .SYNOPSIS
 Start einer Anwendung mit anderen Credentials
 .NOTES
 Credential-Eingabe per [PSCredential]::new() mit Kennwort aus Textdatei
 Es gibt zwei User: psuser und psadmin als Administrator mit demo+123 als Kennwort
#>

$AppName = "powershell.exe"
$AppArgs = "-noprofile -noexit -c Get-Process | Where-Object WS -gt 100MB | Select-Object Name,WS,StartTime;whoami"

$PwPath = Join-Path -Path $PSScriptRoot -ChildPath Pw.dat

# Nur einmal erforderlich
# Read-Host -Prompt "Kennwort" -AsSecureString | ConvertFrom-SecureString | Out-File -FilePath $PwPath

$PWSec = Get-Content -Path $PwPath | ConvertTo-SecureString
$PSCred = [PSCredential]::new("psadmin", $PWSec)

# Start einer Anwendung mit anderen Credentials
Start-Process -FilePath $Appname -ArgumentList $AppArgs -Credential $PSCred