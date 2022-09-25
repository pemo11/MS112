<#
 .SYNOPSIS
 Start einer Anwendung mit anderen Credentials
 .NOTES
 Credential-Eingabe per [PSCredential]::new() mit Kennwort-Abfrage
 Es gibt zwei User: psuser und psadmin als Administrator mit demo+123 als Kennwort
#>

$AppName = "powershell.exe"
$AppArgs = "-noprofile -noexit -c Get-Process | Where-Object WS -gt 100MB | Select-Object Name,WS,StartTime;whoami"

$PWSec = Read-Host -Prompt "Kennwort?" -AsSecureString
$PSCred = [PSCredential]::new("psadmin", $PWSec)

# Start einer Anwendung mit anderen Credentials (aber ohne Administrator-Berechtigung!)
Start-Process -FilePath $Appname -ArgumentList $AppArgs -Credential $PSCred