<#
  .Synopsis
  Eine einfache Men�auswahl
#>

function Show-Menu
{
    Write-Host (New-Object -TypeName String -Args "*", 72)
    Write-Host "Hauptmen�"
    Write-Host (New-Object -TypeName String -Args "*", 72)
    Write-Host -F Green "A - f�r Servermen�"
    Write-Host -F Yellow "B - f�r Clientmen�"
    Write-Host -F Magenta "C - f�r Sonstiges"
    Write-Host -F White "Q - beenden"
    Read-Host -Prompt "?"
}
do
{
  switch ($Auswahl = Show-Menu)
  {
    "A" { "Servermen�" }
    "B" { "Clientmen�" }
    "C" { "Sonstiges" }
  }
} until ($Auswahl -eq "Q")
