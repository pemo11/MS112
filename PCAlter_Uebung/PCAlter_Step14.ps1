<#
 .Synopsis
 Projekt PC-Alter-Abfrage
 .Notes
 Schritt 14: Das Kennwort wird als (zuvor angelegtes) Secret abgerufen
#>

<#
 .Synopsis
 Abfrage aller CPU-Daten
 .Description
 Die Daten stammen aus einem kennwortgeschützten Ftp-Verzeichnis
 .Example
 Get-CPUInfo
#>
function Get-CPUInfo
{
    [CmdletBinding()]
    param([Parameter(ValueFromPipeline=$true, Mandatory=$true)][String[]]$Computername)
    begin
    {
        $ConfigPfad = Join-Path -Path $PSScriptRoot -ChildPath PCAlter.config
        $Config = Import-PowerShellDataFile -Path $ConfigPfad
        # Beim ersten Aufruf von Get-Secret kann eine Passwortabfrage für den Store erforderlich sein, wenn Authenticate für den Store != None ist
        $Pw = Get-Secret -Name PCAlter
        $Cred = [PSCredential]::New($Config.Username, $Pw)
        $CsvPfad = Join-Path -Path $env:TEMP -ChildPath cpu.csv
        Invoke-WebRequest -uri $Config.FtpUri -Credential $Cred -OutFile $CsvPfad
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

Get-CPUInfo -Computername "ServerB", "ServerDC" -Verbose


