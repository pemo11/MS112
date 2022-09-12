<#
 .Synopsis
 Projekt PC-Alter-Abfrage
 .Notes
 Schritt 4: Auswerten der CSV-Daten in einer Function
#>

function Get-CPUData
{
    $CSVPfad = Join-Path -Path $PSScriptRoot -ChildPath "Material/cpu.csv"
    Import-CSV -Path $CSVPfad -Delimiter ";"

}

Get-CPUData