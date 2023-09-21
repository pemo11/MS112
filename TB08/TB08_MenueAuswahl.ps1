<#
  .Synopsis
  Eine einfache Menüauswahl
#>

function Show-Menu
{
    Write-Host (New-Object -TypeName String -Args "*", 72)
    Write-Host "Hauptmenü"
    Write-Host (New-Object -TypeName String -Args "*", 72)
    Write-Host -F Green "A - für Servermenü"
    Write-Host -F Yellow "B - für Clientmenü"
    Write-Host -F Magenta "C - für Sonstiges"
    Write-Host -F White "Q - beenden"
    Read-Host -Prompt "?"
}
do
{
  switch ($Auswahl = Show-Menu)
  {
    "A" { "Servermenü" }
    "B" { "Clientmenü" }
    "C" { "Sonstiges" }
  }
} until ($Auswahl -eq "Q")
