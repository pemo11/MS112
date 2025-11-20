<#
 .SYNOPSIS
 Einfaches Beispiel für einen Regex in PowerShell
#>

$ComputerListe = @(
    "PC-01",
    "Server-02",
    "Laptop-103",
    "Laptop-03X",
    "Workstation-04",
    "Tablet-105",
    "Server06"
)

# Regex-Muster: Computername mit zwei Ziffern
$pattern = "^\w+-\d{2}$"

$ComputerListe | Select-String -Pattern $pattern | ForEach-Object {
    Write-Host "Gefundener Server (Select-String): $($_.Line)" -ForegroundColor Cyan
}

# Warum wird nur Server06 gefunden?