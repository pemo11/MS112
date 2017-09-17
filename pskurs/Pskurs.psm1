<#
 .Synopsis
 Liefert allgemeine Konfigurationsdaten über die Hardware
#>

function Get-ComputerInfo
{
    Get-CimInstance -ClassName Win32_ComputerSystem | Select Name, Manufacturer, Model, SystemType, TotalPhysicalMemory
}

<#
 .Synopsis
 Liefert allgemeine Konfigurationsdaten über das Betriebssystem
#>
function Get-OSInfo
{
    Get-CimInstance -ClassName Win32_OperatingSystem | Select Caption, Version, LastBootUpTime
}

<#
 .Synopsis
 Liefert allgemeine Konfigurationsdaten über die installierten Anwendungen
#>

function Get-AppInfo
{
    $RegPfad1 = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
    $RegPfad2 = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
    Get-ItemProperty -Path $RegPfad1, $RegPfad2 | Select-Object DisplayName, DisplayVersion, Publisher
}

