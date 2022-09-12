<#
 .Synopsis
 Passwort-Generator
#>

function New-Password
{
    [CmdletBinding()]
    param([ValidateRange(8,20)][Int]$Anzahl=8)
    (65..96 | Get-Random -Count $Anzahl).ForEach{[Char]$_} -join ""
}




