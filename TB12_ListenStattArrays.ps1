<#
  .Synopsis
  Listen statt Arrays
#>

#requires -Modules @{ModuleName="poshkurs";RequiredVersion="1.2.0"}

using namespace System.Collections

$UserListe1 = @()
$UserListe2 = [ArrayList]::new()

$t1 = (Measure-Command -Expression {
    (Get-Computerkonten -Anzahl 10000).ForEach{
        $UserListe1 += $_
    }
}).TotalSeconds

# Unterschied macht sich erst bei größeren Listen bemerkbar
$t2 = (Measure-Command -Expression {
    (Get-Computerkonten -Anzahl 10000).ForEach{
        $UserListe2.Add($_)
    }
}).TotalSeconds

Write-Verbose ("*** Array-Variante {0:n2}s" -f $t1) -Verbose
Write-Verbose ("*** Listen-Variante {0:n2}s" -f $t2) -Verbose
