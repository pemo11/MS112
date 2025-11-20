<#
.SYNOPSIS
Ein einfaches PowerShell-Skript zur Demonstration von Debugging-Techniken.
#>

[CmdletBinding()]
param($AnzahlDurchlaeufe = 5)

# Hat nur einen Wert, wenn CmdletBinding() verwendet wird
$PSCmdlet

for($i=0; $i -lt $AnzahlDurchlaeufe; $i++) {
    Write-Host "Durchlauf Nummer: $i"
}

$Liste = @(1, 2, 3, 4, 5)

foreach ($Element in $Liste) {
    Write-Host "Aktuelles Element: $Element"
}

