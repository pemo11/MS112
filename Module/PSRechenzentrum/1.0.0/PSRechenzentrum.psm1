<#
 .Synopsis
 Lade-Modul für alle Klassen
#>

$Ps1Path = Join-Path -Path $PSscriptRoot -ChildPath Rechenzentrum.ps1
.$Ps1Path

$Ps1Path = Join-Path -Path $PSscriptRoot -ChildPath Server.ps1
.$Ps1Path

$Ps1Path = Join-Path -Path $PSscriptRoot -ChildPath SpezialServer.ps1
.$Ps1Path

