<#
  .SYNOPSIS
  Beispiel für ForEach mit -Parallel
  .DESCRIPTION
  Aufruf einer Function über den Umweg eines Moduls
#>

"`e[32m *** Durchlauf Nr. 1 ***`e[0m"

# Das wäre auf die Dauer etwas umständlich
1..10 | ForEach-Object -Parallel {
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
 
  TuWas -i $_
} 

# Diese Variante lädt die Function über ein Modul
"`e[34m *** Durchlauf Nr. 2 ***`e[0m"
$RootPath = $PSScriptRoot
1..10 | ForEach-Object -Parallel { 
  $Psm1Path = Join-Path -Path $using:RootPath -ChildPath "Misc.psm1"
  Import-Module -Name $Psm1Path -Verbose -Force
  TuWas -i $_
}
