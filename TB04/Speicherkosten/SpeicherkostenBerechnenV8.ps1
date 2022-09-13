<#
 .Synopsis
 Speicherkosten berechnen V8
 .Notes
 Die Function arbeitet die Pipeline ab
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
    }

    end {
        $SpeicherkostenGesamt
    }
}

# Regulärer Aufruf 
Get-Speicherkosten -Path ($env:USERPROFILE + "\Pictures") -SpeicherkostenMB  0.2 -Verbose

# Aufruf über die Pipeline
$Pfad = $env:USERPROFILE + "\Pictures\"
# Es werden wieder alle direkten Unterverzeichnisse übergeben 
Get-ChildItem -Path $Pfad -Directory | Get-Speicherkosten -SpeicherkostenMB 0.2 -Verbose

# Das Ergebnis stimmt jetzt "fast" - fasst, weil beim letzten Aufruf das Hauptverzeichnis nicht durchlaufen wird