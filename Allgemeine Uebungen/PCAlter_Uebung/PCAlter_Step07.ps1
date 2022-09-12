<#
 .Synopsis
 Projekt PC-Alter-Abfrage
 .Notes
 Schritt 7: Function mit mehr "Formalitäten"
#>

<#
 .Synopsis
 Abfrage des Alters einer CPU
 .Description
 Grundlage ist die Datei cpu.csv im Unterverzeichnis /material
 .Example
 Get-CPUData "Ryzen 9 3900X"
#>
function Get-CPUData
{
    [CmdletBinding()]
    param([Parameter(Mandatory=$true)][String]$CpuTyp)
    $CSVPfad = Join-Path -Path $PSScriptRoot -ChildPath "Material/cpu.csv"
    Import-CSV -Path $CSVPfad -Delimiter ";" | Where-Object {$CPUTyp -like "*$($_.Name)*"} | 
     Select-Object -Property Manufacturer, Name, @{n="Datum";e={Get-Date -Date $_.CreateDate}}
}

$CPUTyp = "AMD Ryzen 9 3900X 12-Core Processor"

Get-CPUData -CpuTyp $CPUTyp

# Es gibt jetzt auch eine "richtige" Hilfe

Get-CPUData -?

Get-Help Get-CPUData -Full