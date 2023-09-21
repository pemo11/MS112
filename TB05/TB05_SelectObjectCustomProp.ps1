<#
 .Synopsis
  Übung Nr. 4 - Wochentagausgabe
 #>

 $Wochentag = @{
    n="Wochentag"
    e= { $_.CreationTime.DayOfWeek }
 }

 # Get-ChildItem -Path C:\Windows | Select-Object Name, CreationTime, $Wochentag

 # Wichtig: Anstelle von "Montag" soll natürlich der richtige Wochentag ausgegeben werden

 Get-ChildItem -Path C:\Windows | Select-Object -Property Name, CreationTime, $Wochentag |
  Group-Object -Property Wochentag