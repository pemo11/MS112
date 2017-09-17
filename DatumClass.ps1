<#
 .Synopsis
 Übung 3 - eine Klasse für das Abfragen von Zeitspannen
#>

class Dauer
{
  [DateTime]$Datum1

  [DateTime]$Datum2

}


# Tipp: Die Differenz in Tagen muss über eine Methode eingebaut werden (z.B. Tage mit Rückgabewert [Int])
