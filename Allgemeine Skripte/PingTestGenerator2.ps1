<#
 .SYNOPSIS
 Erzeugt Txt-Datei mit Meldungen
#>

param([Int]$Count = 1000, $Delimiter=",")
$TxtPath = Join-Path -Path $PSScriptRoot -ChildPath ("../Material/ServerResponseTime_{0}.txt" -f (Get-Date -Format dd_MM))
$Startzeit = Get-Date
$Lines = (1..$Count).ForEach{
    $i = $_
    $PValue = $i / $Count * 100
    Write-Progress -Activity "Generating Logfile" -Status "Generating Entry $i" `
     -PercentComplete $PValue
    $Jahr = (Get-Date).Year
    $Monat = (Get-Date).Month
    $Tag = (Get-Date).Day
    $Hour = (Get-Date).Hour
    $Minute = 1..59 | Get-Random
    $Second = 1..59 | Get-Random
    $Server = "Server_{0:000}" -f (1..10 | Get-Random)
    $ResponseTime = 1..100 | Get-Random
    [PSCustomObject][Ordered]@{
        TimeStamp = [DateTime]::New($Jahr, $Monat, $Tag, $Hour, $Minute, $Second)
        Server = $Server
        ResponseTimeMs = $ResponseTime
    }
}

$Header = $Lines[0].psobject.Properties.Name -join $Delimiter
Set-Content -Path $TxtPath -Value $Header -Force
foreach($Line in $Lines)
{
    $Line.psobject.Properties.Value -join $Delimiter | Add-Content -Path $TxtPath
}
$Dauer = (Get-Date) - $Startzeit
"Fertig in {0:n2}s" -f $Dauer.TotalSeconds