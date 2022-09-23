Set-StrictMode -Version Latest


<#
 .Synopsis
 Berechnen der Speicherkosten
 .Notes
 Aufaddieren der Dateigröße
#>
function Get-Speicherkosten
{
    [Cmdletbinding()]
    param([Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
     [Alias("FullName")][String]$Path,[Double]$KostenMB, [Switch]$Gesamtkosten)
     begin
     {
       $GesamtkostenMB = 0
     }
     end 
     {
       Write-Verbose "Gesamtkosten = $GesamtkostenMB"
     }
     process
     {
        [Int]$SummeBytes = 0
        Write-Verbose "Bearbeite Verzeichnis $Path"
        Get-ChildItem -Path $Path -Recurse -File -ErrorAction Ignore | ForEach-Object {
            $SummeBytes += $_.Length
        }

        # [PSCustomObject] ist ein "Type Accelerator"
        # Auf Deutsch: Typen-Alias mit einer eingebauten Konvertierungsfunktion
        $output = [PSCustomObject]@{
          # Uebergeordnet = Split-Path -Path $Path
          # Verzeichnis = Split-Path -Path $Path -Leaf
          Verzeichnis = $Path
          Kosten = [Math]::Round( $SummeBytes / 1MB * $KostenMB, 3)
        }
        $output
        # if ($PSBoundParameters.ContainsKey("Gesamtkosten"))
        # Abfrage eines switch-Parameters
        if ($Gesamtkosten)
        {
          $GesamtkostenMB += [Math]::Round( $SummeBytes / 1MB * $KostenMB, 3)
        }
        
    }
}


$MBKosten = 0.2
$DirPath = "D:\2022\Trainings\PowerShell_Fortgeschrittene_Schleupen_2022\MS112_Repo"

# Get-Speicherkosten -Path $DirPath -KostenMB $MBKosten

Get-ChildItem -Path $DirPath -Directory | Get-Speicherkosten -KostenMB $MBKosten -Gesamtkosten -Verbose | 
 Where-Object Kosten -gt 0 | Sort-Object Kosten -Descending

