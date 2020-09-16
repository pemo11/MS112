<#
 .Synopsis
 Beispiel für eine Function mit einer Null-Wert-Validierung
#>

function Test1
{
    [CmdletBinding()]
    param([ValidateNotNull()][String]$P1)
    "P1=$P1"
}

# Aufruf ist ok
Test1 1234

# Aufruf schlägt nicht fehl (!), da in diesem Fall ein Leerstring übergeben wird
Test1

function Test2
{
    [CmdletBinding()]
    # Es geht auch ohne runden Klammern
    param([ValidateNotNullOrEmpty][String]$P1)
    "P1=$P1"
}

# Aufruf ist ok
Test2 bla

# Aufruf schlägt fehl, da ein Leerstring übergeben wird
Test2