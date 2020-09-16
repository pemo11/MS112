<#
 .Synopsis
 Strings zusammensetzen
 .Synopsis
 += versus StringBuilder (.NET-Laufzeit)
#>

using namespace System.Text

$Txt = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua."

$Limit = 20MB
$TextTotal = ""
$Ts1 = (Measure-Command -Expression {
    while($TextTotal.Length -lt $Limit)
    {
        $TextTotal += $Txt    
    }
}).TotalSeconds

$Ts2 = (Measure-Command -Expression {
    $Sb = [StringBuilder]::new()
    while($TextTotal -lt $Sb.Length)
    {
        $Sb.Append($Txt)
    }
}).TotalSeconds

Write-Verbose ("Variante A (+=-Operator): {0:n2}s" -f $Ts1) -Verbose
Write-Verbose ("Variante B (StringBuilder): {0:n2}s" -f $Ts2) -Verbose
