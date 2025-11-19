<#
 .SYNOPSIS
 SSH-Remoting mit einem Skript, das das PoshKurs-Modul verwendet
#>

$IPAdresse = "139.59.146.0"
$Username = "pemo"

$Ps1Code = @'
# Registrieren des Repositories und Installieren des Moduls
if (-not (Get-PSRepository -Name "PoshRepo" -ErrorAction SilentlyContinue)) {
    Register-PSRepository -Name PoshRepo -SourceLocation "https://www.myget.org/F/poshrepo/api/v2"
}
Install-Module -Name Poshkurs -Repository PoshRepo -Scope CurrentUser -Force
$JsonPath = Join-Path -Path "~" -ChildPath "ComputerKonten.json"
Get-Computerkonten -Anzahl 1000 | ConvertTo-Json -Depth 3 | Out-File -FilePath $JsonPath -Encoding UTF8
Write-Host "1000 Computerkonten in Datei $JsonPath gespeichert." -ForegroundColor Green
'@

$Ps1Path = Join-Path -Path $PSScriptRoot -ChildPath "RemoteScriptPoshKurs.ps1"
$Ps1Code | Out-File -FilePath $Ps1Path -Encoding UTF8

Invoke-Command -HostName $IPAdresse -FilePath $Ps1Path -UserName $Username