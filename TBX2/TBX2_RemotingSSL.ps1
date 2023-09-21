<#
 .Synopsis
 PowerShell-Remoting mit SSH
 .Notes
 Auf dem Remote-Computer muss SSH für PowerShell eingerichtet worden sein, am einfachsten per
 Enable-SSHRemoting aus dem Microsoft.PowerShell.RemotingTools-Modul
#>

#requires -version 7.0

# Die Daten in der Datei SSHConfig.psd1 müssen angepasst werden!
$Psd1Pfad = Join-Path -Path $PSScriptRoot -ChildPath "SSHConfig.psd1"
$configData = Import-PowerShellDataFile -Path $Psd1Pfad

$Subsystem = $configData.Subsystem
$Hostname = $configData.Hostname
$Username = $configData.Username

# Kennwort-Eingabe jedes Mal erforderlich - die Alternative wäre Public Key Authentifizierung
$S1 = New-PSSession -Hostname $Hostname -Username $Username -SSHTransport -Subsystem $Subsystem

# Auflisten aller Prozesse auf dem Host-Computer (z.B. Ubuntu Linux mit installierter PowerShell 7.0 und aktiviertem SSH)
Invoke-Command -ScriptBlock { Get-Process } -Session $S1

Remove-PSSession -Session $S1