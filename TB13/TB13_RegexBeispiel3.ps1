<#
 .SYNOPSIS
 Einfaches Beispiel für einen Regex in PowerShell mit Gruppen
#>

$ComputerListe = @(
    "PC-01",
    "Server-02",
    "Laptop-103",
    "Laptop-03X",
    "Workstation-04",
    "Tablet-105",
    "Server06"
)

# Regex-Muster: Computername mit zwei Ziffern
# $pattern = "^(\w+)-*(\d+)\w*$"
# Non greedy Matching
# $pattern = "^(\w+?)-*(\d+)\w*$"
$pattern = "^([A-Za-z]+)-*(\d+)\w*$"

# $ComputerListe | Select-String -Pattern $pattern

# Die Ausgabe muss noch etwas ausgewertet werden, um die Gruppen zu extrahieren

# $Computerliste | Select-String -Pattern $pattern | Select-Object -ExpandProperty Matches

$Computerliste | Select-String -Pattern $pattern | Select-Object -ExpandProperty Matches | ForEach-Object {
    $computerName = $_.Groups[1].Value
    $numberPart = $_.Groups[2].Value
    [PSCustomObject]@{
        ComputerName = $computerName
        NumberPart   = $numberPart
    }
} | Group-Object -Property ComputerName

# Warum ist Server0 ein eigener Match?
# Stichwort: Greedy vs. Lazy Matching