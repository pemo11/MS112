<#
 .Synopsis
 Projekt PC-Alter-Abfrage
 .Notes
 Schritt 10: Eine reguläre WMI-Abfrage mit dem Alter der CPU als zusätzliche Eigenschaft
#>

<#
 .Synopsis
 Abfrage aller CPU-Daten
 .Description
 Grundlage ist die Datei cpu.csv im Unterverzeichnis /material
 .Example
 Get-CPUInfo
#>
function Get-CPUInfo
{
    $CPUData = Get-CimInstance -ClassName Win32_Processor
    $CSVPfad = Join-Path -Path $PSScriptRoot -ChildPath "Material/cpu.csv"
    $CPUInfo = Import-CSV -Path $CSVPfad -Delimiter ";" | Where-Object {$CPUData.Name -like "*$($_.Name)*" }  | 
     Select-Object -Property Name, Manufacturer, @{n="CreateDate";e={Get-Date -Date $_.CreateDate}}
    # Ein neues Objekt zusammenstellen
    [PSCustomObject]@{
        Name = $CPUInfo.Name
        Caption = $CPUData.Name
        Manufacturer = $CPUData.Manufacturer
        CreateDate = $CPUInfo.CreateDate
        Description = $CPUData.Caption
        MaxClockSpeed = $CPUData.MaxClockSpeed
    }
}

Get-CPUInfo

# Es stimmt. aber es gibt noch ein kleines Problem bei CreateDate