<#
 .Synopsis
 Projekt PC-Alter-Abfrage
 .Notes
 Schritt 6: CPU-Typ-Abfrage und Verknüfen mit den CPU-Typen in einer Function
 Die "große Frage" ist oft, wie wird der Rückgabewert der Function festgelegt?
#>

function Get-CPUData
{
    param([String]$CpuTyp)
    $CSVPfad = Join-Path -Path $PSScriptRoot -ChildPath "Material/cpu.csv"
    Import-CSV -Path $CSVPfad -Delimiter ";" | Where-Object {$CPUTyp -like "*$($_.Name)*"} | 
     Select-Object -Property Manufacturer, Name, @{n="Datum";e={Get-Date -Date $_.CreateDate}}
}

$CPUTyp = "AMD Ryzen 9 3900X 12-Core Processor"

Get-CPUData -CpuTyp $CPUTyp

# Der Parametername kann auch weggelassen werden
Get-CPUData $CPUTyp