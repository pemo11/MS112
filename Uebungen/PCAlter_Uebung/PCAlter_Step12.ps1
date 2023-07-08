<#
 .Synopsis
 Projekt PC-Alter-Abfrage
 .Notes
 Schritt 12: Abfrage gegen Daten, die über eine URL heruntergeladen werden
#>

<#
 .Synopsis
 Abfrage aller CPU-Daten
 .Description
 Die Daten stammen von einem "Webservice" bzw.aus einem Ftp-Verzeichnis
 .Example
 Get-CPUInfo
#>
function Get-CPUInfo
{
    [CmdletBinding()]
    param([Parameter(ValueFromPipeline=$true, Mandatory=$true)][String[]]$Computername)
    begin
    {
        # Herunterladen der CSV-Datei aus einem Ftp-Verzeichnis
        # Keine SSL-Problematik, daher gute Alternative zum Http-Download
        $Cred = [PSCredential]::New("ftp12146773-pskurs", (ConvertTo-SecureString -String "posh2021" -AsPlainText -Force))
        $CsvPfad = Join-Path -Path $env:TEMP -ChildPath cpu.csv
        Invoke-WebRequest -uri ftp://wp12146773.server-he.de/posh/cpu.csv -Credential $Cred -OutFile $CsvPfad
    }
    process
    {
        # Für den Fall erforderlich, dass der Name/die Namen dem Parameter direkt zugewiesen werden
        foreach($Computer in $Computername)
        {
            try {
                Write-Verbose "Abfrage gegen $Computer"
                $CimSes = New-CimSession -ComputerName $Computer
                $CPUData = Get-CimInstance -ClassName Win32_Processor -CimSession $CimSes
                $CPUName = $CPUData.Name
                $CPUInfo = Import-CSV -Path $CsvPfad -Delimiter ";" | Where-Object {$CPUName -like "*$($_.Name)*" }  | 
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
