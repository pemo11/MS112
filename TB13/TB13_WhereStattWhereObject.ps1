<#
  .Synopsis
  Where-Erweiterungsmethode statt Where-Object
#>

#requires -Modules @{ModuleName="poshkurs";RequiredVersion="1.2.0"}

using namespace System.Collections

$UserListe = Get-Computerkonten -Anzahl 10000

# Alte Variante mit Where-Object
$t1 = (Measure-Command -Expression {
    $UserListe | Where-Object { $_.Name -like "User5" }
}).TotalSeconds

# Neue Variante mit Where-Erweiterungsmethode
$t2 = (Measure-Command -Expression {
    $UserListe.Where( { $_.Name -like "User5" } )
}).TotalSeconds

Write-Verbose ("*** Where-Object Variante {0:n6}s" -f $t1) -Verbose
Write-Verbose ("*** Where-Erweiterungsmethode Variante {0:n6}s" -f $t2) -Verbose
Write-Verbose ("*** Performance Verbesserung: {0:n2}x" -f ($t1 / $t2)) -Verbose
Write-Verbose "*** Die Pipeline ist einfach langsamer!" -Verbose