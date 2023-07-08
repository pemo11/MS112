<#
 .Synopsis
 Projekt PC-Alter-Abfrage
 .Notes
 Schritt 5: Durchführen einer konkreten Abfrage
#>

function Get-CPUData
{
    $CSVPfad = Join-Path -Path $PSScriptRoot -ChildPath "Material/cpu.csv"
    Import-CSV -Path $CSVPfad -Delimiter ";"

}

$CPUTyp = "AMD Ryzen 9 3900X 12-Core Processor"
Get-CPUData  | Where-Object {$CPUTyp -like "*$($_.Name)*"} | Select-Object -Property CreateDate

# Oder, wenn die Rückgabe ein DateTime-Wert sein soll
Get-CPUData  | Where-Object {$CPUTyp -like "*$($_.Name)*"} | Select-Object -Property @{n="Datum";e={Get-Date -Date $_.CreateDate}}
