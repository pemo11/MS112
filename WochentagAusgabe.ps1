<#
 .Synopsis
  Wochentagausgabe
 #>

 $Wochentag = @{
    n="Wochentag"
    e= { "Montag" }
 }

 dir -Path C:\Windows | Select-Object Name, CreationTime, $Wochentag

 # Wichtig: Anstelle von "Montag" soll natürlich der richtige Wochentag ausgegeben werden