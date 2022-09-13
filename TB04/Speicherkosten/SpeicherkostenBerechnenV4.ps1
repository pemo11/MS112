<#
 .Synopsis
 Speicherkosten berechnen V4
 .Notes
 Die Parameter erhalten Datentypen
#>

# Definition der Function

<#
 .Synopsis
 Berechnen der Speicherkosten
#>
function Get-Speicherkosten
{
    param([String]$Path, [Double]$SpeicherkostenMB)

    $SummeBytes = 0
    Get-ChildItem -Path $Path -Recurse -ErrorAction Ignore | ForEach-Object {
        $SummeBytes += $_.Length
    }
    
    $SpeicherkostenGesamt = [Math]::Round($SummeBytes / 1MB * $SpeicherkostenMB, 3)

    $SpeicherkostenGesamt
}

# Am Aufruf der Function ändert sich nichts
Get-Speicherkosten -Path ($env:USERPROFILE + "\Pictures\") -SpeicherkostenMB  0.2

