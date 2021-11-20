<#
 .Synopsis
 Projekt PC-Alter-Abfrage
 .Notes
 Schritt 3: Auswerten der CSV-Daten
#>

# Es ist sinnvoll, aus einem relativen Pfad einen absoluten Pfad zu machen
$CSVPfad = Join-Path -Path $PSScriptRoot -ChildPath "Material/cpu.csv"

# Dieser Aufruf bringt nichts
# Import-CSV -Path $CSVPfad

# Es kommt auf das Trennzeichen an
Import-CSV -Path $CSVPfad -Delimiter ";"
