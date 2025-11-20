<#
 .Synopsis
 Ein einfacher Passwort-Generator
#>

function Get-Passwort
{
    param([Int]$Staerke=8)
    (1..$Staerke).ForEach{
        # Zufälliger Großbuchstaben
        [Char]((65..91) | Get-Random)
    } -join ""
}

function Get-PasswortEx
{
    param([Int]$Staerke=8, [Switch]$StartWithNumber)
    (1..$Staerke).ForEach{
        if ($StartWithNumber -and $_ -eq 1) {
            # Erstes Zeichen ist eine Zahl
            [Char](48..57 | Get-Random)
        }
        else {
            # Zufälliges Zeichen (Zahlen + Großbuchstaben)
            [Char]((48..57),(65..91) | Get-Random)
        }
    } -join ""
}