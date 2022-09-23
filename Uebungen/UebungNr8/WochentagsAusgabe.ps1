<#
 .Synopsis
 Übung Nr. 8 - Ausgabe aller Wochentage eines Monats, die kein Samstag/Sonntag sind
 #>

# Zum Kennenlernen
$Monat = "August"
$d = Get-Date -Date $Monat/2020
$d

[DateTime]::DaysInMonth(2020, 8)

(Get-Date -Date "1.8.2020").DayOfWeek

function Get-Wochentage
{
    param($Monat)

    # Was muss hier also stehen?
}