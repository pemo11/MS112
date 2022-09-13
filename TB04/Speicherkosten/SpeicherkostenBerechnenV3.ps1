<#
 .Synopsis
 Speicherkosten berechnen V3
 .Notes
 Die Function mit einfachen Parametern
#>

# Definition der Function

<#
 .Synopsis
 Berechnen der Speicherkosten
#>
function Get-Speicherkosten
{
    param($Path, $SpeicherkostenMB)

    $SummeBytes = 0
    Get-ChildItem -Path $Path -Recurse -ErrorAction Ignore | ForEach-Object {
        $SummeBytes += $_.Length
    }
    
    $SpeicherkostenGesamt = [Math]::Round($SummeBytes / 1MB * $SpeicherkostenMB, 3)

    $SpeicherkostenGesamt
}

# Aufruf der Function - dieses Mal mit Argumenten
Get-Speicherkosten -Path ($env:USERPROFILE + "\Pictures\") -SpeicherkostenMB  0.2

