<#
 .SYNOPSIS
 Einlesen einer Textdatei in ein Dictionary
 .NOTES
 Die Erweiterung .psd1 für PowerShell Datafile ist optional
#>

$Psd1Path = Join-Path -Path $PSScriptRoot -ChildPath .\ServerDaten.psd1

# Einlesen der Daten in ein Dictionary - Import-PowerShellDataFile ist bei der Windows PowerShell eine Function, bei PowerShell 7 ein Cmdlet
$Data = Import-PowerShellDataFile -Path $Psd1Path

# Was wird hier zurückgegeben?
$Data

# Was wird hier zurückgegeben?
$Data["Server1"]