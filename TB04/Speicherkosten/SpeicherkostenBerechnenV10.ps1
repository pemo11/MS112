<#
 .Synopsis
 Speicherkosten berechnen V10
 .Notes
 Optionale Gesamtkostenberechnung dank switch-Parameter
 #>

# Definition der Function

<#
 .Synopsis
 Berechnen der Speicherkosten
#>
function Get-Speicherkosten
{
    [CmdletBinding()]
    param([Alias("FullName")][Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true)][String]$Path,
    [Double]$SpeicherkostenMB,
    [Switch]$Gesamtkosten)

    begin {
        $SpeicherkostenGesamt = 0
        $Speicherkosten = 0
    }
    process {
        Write-Verbose "Berechne die Speicherkosten für $Path"
        $SummeBytes = 0
        Get-ChildItem -Path $Path -Recurse -ErrorAction Ignore | ForEach-Object {
            if (Test-Path $_.FullName -PathType Container)
            {
                Write-Verbose "Berechne die Speicherkosten für $($_.FullName)"
            }
            $SummeBytes += $_.Length
        }
    
        $Speicherkosten = [Math]::Round($SummeBytes / 1MB * $SpeicherkostenMB, 3)
        $SpeicherkostenGesamt += $Speicherkosten
        [PSCustomObject]@{Pfad=$Path;Kosten=$Speicherkosten}
    }

    end {
        if ($PSBoundParameters.ContainsKey("Gesamtkosten"))
        {
           $AusgangsPfad = (Get-Item -Path $Path).Parent.FullName
           [PSCustomObject]@{Pfad=$AusgangsPfad;Kosten=$SpeicherkostenGesamt}
        }
    }
}

$Pfad = $env:USERPROFILE + "\Pictures\"
# Aufruf ohne Switch-Parameter
Get-ChildItem -Path $Pfad -Directory | Get-Speicherkosten -SpeicherkostenMB 0.2

# Aufruf mit Switch-Parameter
Get-ChildItem -Path $Pfad -Directory | Get-Speicherkosten -SpeicherkostenMB 0.2 -Gesamtkosten


