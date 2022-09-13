<#
 .Synopsis
 Speicherkosten berechnen V6
 .Notes
 [CmdletBinding()] kommt dazu und der Verbose-Parameter wird genutzt 
 #>

# Definition der Function

<#
 .Synopsis
 Berechnen der Speicherkosten
#>
function Get-Speicherkosten
{
    [CmdletBinding()]
    param([Parameter(Mandatory=$true)][String]$Path, [Double]$SpeicherkostenMB=.2)

    Write-Verbose "Berechne die Speicherkosten für $Path"
    $SummeBytes = 0
    Get-ChildItem -Path $Path -Recurse -ErrorAction Ignore | ForEach-Object {
        if (Test-Path $_.FullName -PathType Container)
        {
            Write-Verbose "Berechne die Speicherkosten für $($_.FullName)"
        }
        $SummeBytes += $_.Length
    }

    $SpeicherkostenGesamt = [Math]::Round($SummeBytes / 1MB * $SpeicherkostenMB, 3)

    $SpeicherkostenGesamt
}

# Regulärer Aufruf ohne Meldungen
Get-Speicherkosten -Path ($env:USERPROFILE + "\Pictures\") -SpeicherkostenMB  0.2

# Durch den Verbose-Parameter werden alle Verbose-Meldungen auch ausgegeben
Get-Speicherkosten -Path ($env:USERPROFILE + "\Pictures\") -SpeicherkostenMB  0.2 -Verbose

