<#
 .SYNOPSIS
 Beispiel für ein Modul mit einer globalen Variablen
#>

$LastError = $null

function f1
{
    $Script:LastError = $null
    if ((Get-Random -Maximum 10) -gt 5)
    {
        $Script:LastError = "Fehler in f1"
    }
}

function f2
{
    $Script:LastError = $null
    if ((Get-Random -Maximum 10) -gt 6)
    {
        $Script:LastError = "Fehler in f2"
    }
}

function f3
{
    $Script:LastError = $null
    if ((Get-Random -Maximum 10) -gt 7)
    {
        $Script:LastError = "Fehler in f3"
    }
}

# Keine Voraussetzung, aber sinnvoll
Export-ModuleMember -Function f1,f2,f3 -Variable LastError