<#
 .Synopsis
 Speicherkosten berechnen V2
 .Notes
 Alle Befehle sind Teil einer Function
#>

# Definition der Function

<#
 .Synopsis
 Berechnen der Speicherkosten
#>
function Get-Speicherkosten
{
    $Path = $env:USERPROFILE + "\Pictures\"
    $SpeicherkostenMB = 0.2

    $SummeBytes = 0
    Get-ChildItem -Path $Path -Recurse -ErrorAction Ignore | ForEach-Object {
        $SummeBytes += $_.Length
    }
    
    $SpeicherkostenGesamt = [Math]::Round($SummeBytes / 1MB * $SpeicherkostenMB, 3)

    $SpeicherkostenGesamt
}

# Aufruf der Function
Get-Speicherkosten
