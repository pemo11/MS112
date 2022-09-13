<#
 .Synopsis
 Speicherkosten berechnen V1
 .Notes
 Nur eine Befehlsfolge, keine Function
#>

$Path = $env:USERPROFILE + "\Pictures\"
$SpeicherkostenMB = 0.2

$SummeBytes = 0

# Die Größe aller Dateien in allen Verzeichnissen aufsummieren
Get-ChildItem -Path $Path -Recurse -ErrorAction Ignore | ForEach-Object {
    $SummeBytes += $_.Length
}

$SpeicherkostenGesamt = [Math]::Round($SummeBytes / 1MB * $SpeicherkostenMB, 3)

$SpeicherkostenGesamt