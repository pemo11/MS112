<#
 .Synopsis
 Projekt PC-Alter-Abfrage
 .Notes
 Schritt 11: Abfrage gegen Computer im Netzwerk per WMI
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
    [CmdletBinding()]
    param([Parameter(ValueFromPipeline=$true, Mandatory=$true)][String[]]$Computername)
    process
    {
        # Für den Fall erforderlich, dass der Name/die Namen dem Parameter direkt zugewiesen werden
        foreach($Computer in $Computername)
        {
            try {
                Write-Verbose "Abfrage gegen $Computer"
                $CimSes = New-CimSession -ComputerName $Computer
                $CPUData = Get-CimInstance -ClassName Win32_Processor -CimSession $CimSes
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
            catch {
                Write-Warning "Fehler bei der Abfrage von $Computer ($_))"
            }
        }
    }
 
}

Get-CPUInfo -Computername "PowerPc", "PowerPc" -Verbose


"Localhost", "Localhost" | Get-CPUInfo -Verbose
