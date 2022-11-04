<#
.Synopsis
Beispiel für eine Advanced Function
#>

function Get-Speicherkosten
{
    [CmdletBinding()]
    param([Alias("Fullname")][Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
     [String]$Path,[Double]$KostenMB)
    process
    {
        $GroesseGesamt = 0
        Write-Verbose "Durchsuche Verzeichnis $($_.FullName)"
        Get-ChildItem -Path $_.FullName -File | ForEach-Object {
            $GroesseGesamt += $_.Length
        }
        [PSCustomObject]@{
            Verzeichnis =  $_.FullName
            Kosten = $GroesseGesamt / 1MB * $KostenMB
        }
    }
}


<#
$Esc = [Char]27
Get-Speicherkosten -KostenMB 200 $env:USERPROFILE | Where-Object { $_.Kosten -gt 0 -and $_.Verzeichnis.Length -lt 100 }| 
 Sort-Object Kosten | Select-Object -First 10 | Format-Table -AutoSize -Property Verzeichnis, 
 @{l="KostenMB";f="C";e={$Kosten=$_.Kosten;if($Kosten-gt0.04)
    {"$Esc[31m$Kosten$Esc[0m"}else{"$Esc[32m$Kosten$Esc[0m"}}}
#>

# Get-ChildItem -Path $env:USERPROFILE\Documents -Directory | Get-Speicherkosten -KostenMB 100



Get-Speicherkosten -KostenMB 100 -Path $env:USERPROFILE\Documents