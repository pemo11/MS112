<#
 .SYNOPSIS
 Gibt Infos über den PC zurück
#>

# Abfrage der OS-Details

$OS = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object Caption, BuildNumber, InstallDate, SerialNumber

$PC = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object  Manufacturer, Model, TotalPhysicalMemory

[PSCustomObject]@{
    OSCaption = $OS.Caption
    OSBuildNummer = $OS.BuildNumber
    OSInstallDate = $OS.InstallDate
    PCManufacturer = $PC.Manufacturer
    PCModel = $PC.Model
    PCMemory = $PC.TotalPhysicalMemory

}
