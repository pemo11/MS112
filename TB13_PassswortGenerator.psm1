<#
 .Synopsis
 Ein einfacher Passwort-Generator
#>

function Get-Passwort
{
    param([Int]$Staerke=8)
    (1..$Staerke).ForEach{
        [Char]((48..57),(65..91) | Get-Random)
    } -join ""
}