# D:\Skriptkiste\Powershell\Regex\WebserverLogs

# Here-String
$ServerListe = @"
ServerX1
Server1234
ServerB5
ServerA
Server-4
1000-XYZ
Server-89A
"@

# Ausgabe aller Nummern im jeweiligen Namen

$muster = "^([A-Za-z]+)-*([0-9]+)"
# $muster = "[a-zA-Z-]+\d+"
# ($ServerListe -split "`n") -match $muster
 $ServerListe -split "`n" | ForEach-Object {
    if ($_ -match $muster)
    {
        # Abfrage der zweiten Gruppe ([0-9]+)
        $Matches[2]
    }
 }

