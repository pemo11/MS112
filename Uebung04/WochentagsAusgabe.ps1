<#
 .Synopsis
 Übung Nr. 4 - Ausgabe aller Wochentage, die kein Samstag/Sonntag sind
 #>

$Monat = "August"
$d = Get-Date -Date $Monat/2020

[DateTime]::DaysInMonth(2020, 8)

(Get-Date -Date "1.8.2020").DayOfWeek