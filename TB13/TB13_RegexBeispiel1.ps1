<#
 .SYNOPSIS
 Einfaches Beispiel für einen Regex in PowerShell
#>

$ComputerListe = @(
    "PC-01",
    "Server-02",
    "Laptop-03",
    "Workstation-04",
    "Tablet-05"
)

# Regex-Muster: Computername, der mit "Server" beginnt
$pattern = "^Server.*"
$ComputerListe | Where-Object { $_ -match $pattern } | ForEach-Object {
    Write-Host "Gefundener Server: $_" -ForegroundColor Green
} 

# Alternativ mit Select-String
$ComputerListe | Select-String -Pattern $pattern | ForEach-Object {
    Write-Host "Gefundener Server (Select-String): $($_.Line)" -ForegroundColor Cyan
}