<#
 .Synopsis
  Übung Nr. 4 - Wochentagausgabe
 #>

 $Wochentag = @{
    n="Wochentag"
    e= { $_.CreationTime.DayOfWeek }
 }

 dir -Path C:\Windows | Select-Object Name, CreationTime, $Wochentag

 # Wichtig: Anstelle von "Montag" soll natürlich der richtige Wochentag ausgegeben werden