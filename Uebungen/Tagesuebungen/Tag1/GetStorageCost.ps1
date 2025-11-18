
function Get-StorageCost {
    [CmdletBinding()]
    param([Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)][Alias("PsPath")][string]$Path, [Parameter(Mandatory=$true)][int]$KostenMB)
    begin {
        $Ausgabe = @()
    }
    Process
    {
        $GroesseGesamt = 0
        Write-Verbose "Durchsuche Verzeichnis $Path"
        Get-ChildItem -Path $Path -File | ForEach-Object {
            $GroesseGesamt += $_.Length
        }
        $KostenGesamt = ($GroesseGesamt / 1MB) * $KostenMB
        $Ausgabe += [PSCustomObject]@{
            Verzeichnis = $_
            Kosten = [math]::Round($KostenGesamt, 2)
        } 
    }
    end {
        $Ausgabe | Out-Host
        Write-Host "Fertig..."
    }
}

Get-ChildItem $env:userprofile -Directory | Get-StorageCost -KostenMB 100 -Verbose:$false | Where-Object Kosten -gt 0