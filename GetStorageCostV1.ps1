# Übung Nr. 2

function Get-StorageCost
{
    <#
     .Synopsis
     Berechnet die Speicherkosten für einen Verzeichnisinhalt
    #>
    [CmdletBinding()]
    param([Parameter(Mandatory=$true)][String]$Path,
          [Double]$CostMB=0.02)

    $SizeMB = (Get-ChildItem -Path $Path -File -ErrorAction Ignore | Measure-Object -Property Length -Sum).Sum / 1MB
    return [Math]::Round($SizeMB * $CostMB, 2)

}