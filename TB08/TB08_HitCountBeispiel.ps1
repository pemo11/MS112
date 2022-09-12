<#
 .Synopsis
 Haltepunkt, der von der Anzahl der "Hits" abhängig ist
 .Notes
 Haltepunkt muss in Zeile 12 gesetzt werden
#>

$i = 0
while($true)
{
    $i++
    "Durchlauf Nr. $i"
    Start-Sleep -Seconds 1
}