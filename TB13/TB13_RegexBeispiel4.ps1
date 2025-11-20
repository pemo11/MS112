<#
 .SYNOPSIS
 Replace per Regex
#>

$Datum = "2024-06-15 14:30:45"

# Regex-Muster für Datum im Format YYYY-MM-DD HH:MM:SS
$pattern = "^(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})$"
# Ersetzen durch DD.MM.YYYY HH:MM:SS
$ersatz = '$3.$2.$1 $4:$5:$6'
$neuesDatum = $Datum -replace $pattern, $ersatz
Write-Host "Ursprüngliches Datum: $Datum" -ForegroundColor Yellow
Write-Host "Neues Datum: $neuesDatum" -ForegroundColor Green

# -split verwendet immer (!) einen Regex
$Wert = "1.2.3.4"
$Wert -split "\."