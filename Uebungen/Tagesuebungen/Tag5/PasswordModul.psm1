<# 
 .SYNOPSIS
 Modul mit diversen Functions
#>

<#
 .SYNOPSIS
  Funktion zum generieren eines Passwortes
#>
function Get-Password
{
    param([Parameter(Mandatory=$true)][int]$length,[Switch]$SpecialChar)
    $pw = ""
    if ($length -gt 0)
    {
        if ($SpecialChar)
        {
            $Pw = [Char]33..47 | Get-Random 
        }
        $Pw += (1..$length).ForEach{[Char](65..91 | Get-Random)} -join ""
        $Pw
    }
    else
    {
        $Pw
    }
}