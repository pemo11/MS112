<#
 .Synopsis
 Übung Nr. 2
#>

function Get-StorageCost
{
    [CmdletBinding()]
    param([String]$Path, [Double]$KostenMB=0.25)
    $SummeBytes = 0
    Get-ChildItem -Path $Path -File -Recurse | ForEach-Object {
        $SummeBytes += $_.Length
    }
    [PSCustomObject]@{
        Verzeichnis = $Path
        KostenMB = $SummeBytes / 1MB * $KostenMB
    }
}