<#
 .Synopsis
 Beispiel für Skript, das die Pipeline abarbeitet
#>

param([Parameter(ValueFromPipelineByPropertyName=$true)][Alias("PSPath")][String]$Path,
      [Double]$SpeicherkostenMB=0.8)

process
{
  Get-ChildItem -Path $Path -Directory -Recurse | ForEach {
      $GroesseMB = (Get-ChildItem -Path $_.FullName -File | Measure-Object -Property Length -Sum).Sum / 1MB
      $Speicherkosten = $GroesseMB * $SpeicherkostenMB
      New-Object -TypeName PSObject -Property @{Pfad=$_.FullName;
                                                Speicherkosten=$Speicherkosten}
  }
}
