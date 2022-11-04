<#
 .Synopsis
 Skript per SSH-Remoting ausführen
#>

$HostIP = "23.97.155.73"
$Username = "pemo"
$Ps1Path = Join-Path -Path $PSScriptRoot -ChildPath "PCInfo.ps1"

$S1 = New-PSSession -HostName $HostIP -UserName $Username

Invoke-Command -Session $S1 -FilePath $Ps1Path

$S1 | Remove-PSSession
