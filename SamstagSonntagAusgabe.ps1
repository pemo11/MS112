<#
 .Synopsis
 Übung Nr. 6 - Samstag- und Sonntagausgabe
 #>

 # Aktuelles Jahr und Monat holen
$Jahr = (Get-Date).Year
$Monat = (Get-Date).Month

$TageProMonat = [DateTime]::DaysInMonth($Jahr, $Monat)

# Der folgende Befehl holt alle Tage des Monats und gibt den Wochentag aus
1..$TageProMonat | Select-Object @{n="Datum";e={Get-Date -Year $Jahr -Month $Monat -Day $_ -Format dddd }}

# Wie muss der Filterausdruck aussehen, dass nur Samstage und Sonntage ausgegeben werden
# Tipp: Es wird kein weiteres Cmdlet benötigt, sondern nur ein Ausdruck!
ä 1..$TageProMonat | Where-Object {  }