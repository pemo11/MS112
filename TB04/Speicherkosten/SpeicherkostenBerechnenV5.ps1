<#
 .Synopsis
 Speicherkosten berechnen V5
 .Notes
 Die Parameter erhalten weitere Angaben über das Parameter-Attribut und einen Default-Wert.
#>

# Definition der Function

<#
 .Synopsis
 Berechnen der Speicherkosten
#>
function Get-Speicherkosten
{
    param([Parameter(Mandatory=$true)][String]$Path, [Double]$SpeicherkostenMB=.2)

    $SummeBytes = 0
    Get-ChildItem -Path $Path -Recurse -ErrorAction Ignore | ForEach-Object {
        $SummeBytes += $_.Length
    }
    
    $SpeicherkostenGesamt = [Math]::Round($SummeBytes / 1MB * $SpeicherkostenMB, 3)

    $SpeicherkostenGesamt
}

# Am Aufruf der Function ändert sich immer noch nichts
Get-Speicherkosten -Path ($env:USERPROFILE + "\Pictures\") -SpeicherkostenMB  0.2

# Wird für Path kein Wert übergeben, wird er abgefragt
Get-Speicherkosten -SpeicherkostenMB  0.2

# Für SpeicherkostenMB muss kein Wert übergeben werden
Get-Speicherkosten -Path ($env:USERPROFILE + "\Pictures\")
