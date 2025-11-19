<#
 .SYNOPSIS
 SSH-Remoting mit Hostname und Username aus einer Config-Datei
#>

$configPath = Join-Path -Path $PSScriptRoot -ChildPath "SSHConfig.psd1"
if (-not (Test-Path -Path $configPath)) {
    Write-Error "Config-Datei $configPath nicht gefunden!"
    exit 1
}

$configPath = Join-Path -Path $PSScriptRoot -ChildPath "SSHConfig.psd1"
$config = Import-PowerShellDataFile -Path $configPath

$IPAdresse = $config.Hostname
$Username = $config.Username

# Verbindung mit Public Key Authentifizierung herstellen
$S1 = New-PSSession -HostName $IPAdresse -UserName $Username
Invoke-Command -Session $S1 -ScriptBlock { whoami ; hostname }

$S1 | Remove-PSSession -Verbose