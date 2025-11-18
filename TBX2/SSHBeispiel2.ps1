<#
 .SYNOPSIS
 Ausführen eines Skriptes per SSH-Remoting 
#>

# $HostName = "ubuntu1"
$IPAdresse = "139.59.146.0"
$Username = "pemo"

# Verbindung mit Public Key Authentifizierung herstellen
$S1 = New-PSSession -HostName $IPAdresse -UserName $Username

# Ein kleines Skript auf dem Remote-Host ausführen
$Ps1Code = @'
Write-Host "Hallo vom Remote-Host!" -ForegroundColor Green
Get-Process | Select-Object -First 5
whoami
hostname
'@

$Ps1Path = Join-Path -Path $PSScriptRoot -ChildPath "RemoteScript.ps1"
$Ps1Code | Out-File -FilePath $Ps1Path -Encoding UTF8

Invoke-Command -Session $S1 -FilePath $Ps1Path


Get-PSSession | Remove-PSSession -Verbose
