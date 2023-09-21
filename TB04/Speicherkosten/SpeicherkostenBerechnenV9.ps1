<#
 .Synopsis
 Speicherkosten berechnen V9
 .Notes
 Objektausgabe statt Textausgabe
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
    [Double]$SpeicherkostenMB)

    
    begin {
        $SpeicherkostenGesamt = 0
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
    
        $SpeicherkostenGesamt += [Math]::Round($SummeBytes / 1MB * $SpeicherkostenMB, 3)
        [PSCustomObject]@{
            Pfad=$Path
            Kosten=$SpeicherkostenGesamt
        }
    }

    end {
    }
}

# Regulärer Aufruf 
Get-Speicherkosten -Path ($env:USERPROFILE + "\Pictures") -SpeicherkostenMB  0.2 -Verbose

# Aufruf über die Pipeline
$Pfad = $env:USERPROFILE + "\Pictures\"
Get-ChildItem -Path $Pfad -Directory | Get-Speicherkosten -SpeicherkostenMB 0.2 -Verbose

