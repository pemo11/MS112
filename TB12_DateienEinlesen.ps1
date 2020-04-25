<#
 .Synopsis
 Geschwindigkeitsunterschiede beim Einlesen einer Textdatei
 .Description
 Get-Content versus StreamReader
 .Notes
 Grundsätzliche Überlegungen:
 >Auch Get-Content wurde inzwischen optimiert
 >Die Unterschiede fallen unterschiedlich aus
 >Es ist generell wichtig zu wissen, welche Alternativen es gibt
#>

using namespace System.IO
using namespace System.Text

# Schritt 1: Eine große Textdatei anlegen
$TxtPfad = [Path]::GetTempFileName()

$Txt = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua."
$Limit = 25MB
$Sb = [StringBuilder]::new()
while($Sb.Length -lt $Limit)
{
    [void]$Sb.Append($Txt)
}

# Jetzt in eine Datei speichern
$Sw = [StreamWriter]::new($TxtPfad)
$Sw.Write($Sb)
$Sw.Close()
Write-Verbose ("{0} Bytes wurden in $TxtPfad geschrieben." -f $Sb.Length) -Verbose

# Variante A: Get-Content
$Ts1 = (Measure-Command -Expression {
    $Txt = Get-Content -Path $TxtPfad
}).TotalSeconds

# Variante B: StreamReader
$Ts2 = (Measure-Command -Expression {
    $Sr = [StreamReader]::New($TxtPfad)
    $Txt = $Sr.ReadToEnd()
}).TotalSeconds

Write-Verbose ("Variante A (Get-Content): {0:n2}s" -f $Ts1) -Verbose
Write-Verbose ("Variante B (StreamReader): {0:n2}s" -f $Ts2) -Verbose
