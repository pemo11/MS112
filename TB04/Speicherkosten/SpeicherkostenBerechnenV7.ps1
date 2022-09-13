<#
 .Synopsis
 Speicherkosten berechnen V7
 .Notes
 Der Path-Parameter wird Pipeline-Bindungsfähig gemacht - wichtig ist, dass der Parameter den Alias FullName erhält
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

    $SummeBytes = 0
    Write-Verbose "Berechne die Speicherkosten für $Path"
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

# Regulärer Aufruf 
Get-Speicherkosten -Path ($env:USERPROFILE + "\Pictures\") -SpeicherkostenMB  0.2 -Verbose

# Aufruf über die Pipeline
$Pfad = $env:USERPROFILE + "\Pictures\"
# Jetzt alle Unterverzeichnisse einzeln berechnen (aber ohne das Hauptverzeichnis)
Get-ChildItem -Path $Pfad -Directory | Get-Speicherkosten -SpeicherkostenMB 0.2 -Verbose

# Das Ergebnis beim zweiten Aufruf stimmt nicht - im ersten Durchlauf das erwartete Ergebnis, im zweiten Durchlauf z.B. 0.025
# Verbose zeigt, dass die Pipebindung zwar funktioniert, aber nur ein Durchlauf durchgeführt wird