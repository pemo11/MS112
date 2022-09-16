<#
  .Synopsis
  Beispiel für ForEach mit -AsParallel
#>

#requires -Version 7

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


# Reguläre Ausführung

# 1..10 | ForEach-Object { &$TuWasPtr -i $_ }

# Parallele Ausführung - so geht es nicht - TuWas ist nicht bekannt
# 1..10 | ForEach-Object -Parallel { TuWas -i $_ } 
# $TuWasPtr = "TuWas"
# 1..10 | ForEach-Object -Parallel { &$using:TuWasPtr -i $_ } 

"*** Durchlauf Nr. 1 ***"
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

# Diese Variante geht auch nicht
$SB = {
      param(
          [Parameter(Mandatory=$true)]
          [int]$i
      )
      Write-Host "Starte $i"
      Start-Sleep -Seconds 1
      Write-Host "Beende $i"
}

# 1..10 | ForEach-Object -Parallel { $using:SB.Invoke($_) }

# Diese Variante geht dann endlich
"*** Durchlauf Nr. 2 ***"
$RootPath = $PSScriptRoot
1..10 | ForEach-Object -Parallel { 
  $Psm1Path = Join-Path -Path $using:RootPath -ChildPath "Misc.psm1"
  Import-Module -Name $Psm1Path -Verbose -Force
  TuWas -i $_
}
