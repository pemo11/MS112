<#
 .SYNOPSIS
 Erzeugt Txt-Datei mit Meldungen
 .NOTES
 Der Output dieses Skriptes ist etwas "problematisch", eignet sich aber trotzdem für
 eine Übung, da Textdaten nicht immer optimal aufbereitet werden
#>

$Count = 1E6
$TxtPath = Join-Path -Path $PSScriptRoot -ChildPath ("../Material/ServerResponseTime_{0}.txt" -f (Get-Date -Format dd_MM))

(1..$Count).ForEach{
    $PValue = $_ / $Count * 100
    # Write-Progress -Activity "Generating Logfile" -Status "Generating Entry $_" -PercentComplete $PValue
    $Jahr = (Get-Date).Year
    $Monat = (Get-Date).Month
    $Tag = (Get-Date).Day
    $Hour = (Get-Date).Hour
    $Minute = 1..59 | Get-Random
    $Second = 1..59 | Get-Random
    $Server = "Server_{0:000}" -f (1..10 | Get-Random)
    $ResposeTime = 1..100 | Get-Random
    [PSCustomObject][Ordered]@{
        TimeStamp = [DateTime]::New($Jahr, $Monat, $Tag, $Hour, $Minute, $Second)
        Server = $Server
        ResponseTimeMs = $ResposeTime
    }
} | Out-File -FilePath $TxtPath