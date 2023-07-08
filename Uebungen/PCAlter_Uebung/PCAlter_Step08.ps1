<#
 .Synopsis
 Projekt PC-Alter-Abfrage
 .Notes
 Schritt 8: Es sollen mehrere Abfragen möglich sein
#>

<#
 .Synopsis
 Abfrage des Alters einer CPU
 .Description
 Grundlage ist die Datei cpu.csv im Unterverzeichnis /material
 .Example
 Get-CPUData "Ryzen 9 3900X","Ryzen 9 5950X"
 #>
function Get-CPUData
{
    # aus String wird String[] - damit können beliebig viele Werte übergeben werden
    [CmdletBinding()]
    param([Parameter(Mandatory=$true)][String[]]$CpuTyp)
    $CSVPfad = Join-Path -Path $PSScriptRoot -ChildPath "Material/cpu.csv"
    Import-CSV -Path $CSVPfad -Delimiter ";" | Where-Object {$CPUTyp -like "*$($_.Name)*"} | 
     Select-Object -Property Manufacturer, Name, @{n="Datum";e={Get-Date -Date $_.CreateDate}}
}

$CPUTypen = @("AMD Ryzen 9 3900X 12-Core Processor","AMD Ryzen 9 5950X")

Get-CPUData -CpuTyp $CPUTypen

# Es funktioniert, es sollte aber auch eine Pipeline-Aufruf möglich sein
# $CPUTypen | Get-CPUData
# Das geht aktuell noch nicht
