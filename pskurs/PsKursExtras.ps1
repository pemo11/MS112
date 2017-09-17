<#
 .Synopsis
 Liefert allgemeine Konfigurationsdaten über den lokalen Computer
#>
function Get-PCInfo
{
    $OS = Get-OSInfo
    $Computer = Get-ComputerInfo
    [PSCustomObject]@{
        Name = $Computer.Name
        OSName = $OS.Caption
        OSVersion = $OS.Version
        PCHersteller = $Computer.Manufacturer
    }

}