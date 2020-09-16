<#
 .Synopsis
 Beispiel für eine Function mit Mandatory-Parameter
#>

function Test
{
    [CmdletBinding()]
    param([Parameter(Mandatory=$true)][String]$P1)

    "P1=$P1"
}

# Aufruf ohne Pflichtparameterwert - Wird wird abgefragt

Test

# Aufruf mit Pflichtparameterwert
Test 1234