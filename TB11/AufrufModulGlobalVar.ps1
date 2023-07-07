<#
 .SYNOPSIS
 Verwenden eines Moduls mit globalen Variablen
#>

$psm1Path = Join-path -path $PSScriptRoot -childpath "ModulMitglobalerVar.psm1"
Import-Module -Name $psm1Path -Force

f1
"Aufruf von f1 - LastError=$LastError"

f2
"Aufruf von f2 - LastError=$LastError"

f3
"Aufruf von f3 - LastError=$LastError"
