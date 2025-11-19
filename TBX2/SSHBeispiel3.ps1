<#
 .SYNOPSIS
 SSH-Remoting mit Skript und Parameter
#>

# $HostName = "ubuntu1"
$IPAdresse = "139.59.146.0"
$Username = "pemo"

$Ps1Code = @'
param (
    [Parameter(Mandatory=$true)][Int]$LimitKB
)
    Write-Host "Hallo vom Remote-Host!" -ForegroundColor Green
    Write-Host "Prozesse mit weniger als $LimitKB KB Arbeitsspeicher:" -ForegroundColor Yellow
    Get-Process | Where-Object { ($_.WS / 1KB) -lt $LimitKB } |
      Format-Table Name, Id, @{Name="WorkingSet(KB)";Expression={ [Math]::Round($_.WS / 1KB, 2) }} -AutoSize
'@

$Ps1Path = Join-Path -Path $PSScriptRoot -ChildPath "RemoteScriptParam.ps1"
$Ps1Code | Out-File -FilePath $Ps1Path -Encoding UTF8

# Verbindung mit Public Key Authentifizierung herstellen
$S1 = New-PSSession -HostName $IPAdresse -UserName $Username
# Ein Skript mit Parameter auf dem Remote-Host ausführen
Invoke-Command -Session $S1 -FilePath $Ps1Path -ArgumentList 1000

Get-PSSession | Remove-PSSession -Verbose