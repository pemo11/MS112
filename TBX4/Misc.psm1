<#
 .SYNOPSIS
 Enthält diverse Functions, die nichts Besonderes machen
#>

<#
 .SYNOPSIS
 Gibt etwas mit einer Verzögerung aus
#>
function TuWas
{
    param(
        [Parameter(Mandatory=$true)]
        [int]$i
    )
    Write-Host "Starte $i"
    Start-Sleep -Seconds 1
    Write-Host "Beende $i"
}
