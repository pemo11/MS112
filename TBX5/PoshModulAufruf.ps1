<#
 .SYNOPSIS
 Aufruf des PoshModul-Moduls
#>

$Psm1Path = Join-Path -Path $PSScriptRoot -ChildPath "PoshModul.psm1"
Import-Module -Name $Psm1Path -Force

try {
    Get-PCInfo      
}
catch {
    Write-Warning "Fehler beim Aufruf der Get-PCInfo-Funktion: $_"
}
