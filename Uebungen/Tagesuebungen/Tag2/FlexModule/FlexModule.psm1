<#
    .SYNOPSIS
    Ein Modul mit diversen Funktionen
#>
param($Mode)

<#
    .SYNOPSIS
    Führt Funktion f1 aus
#>
function f1
{
    "Function f1 executed."
}

function f2
{
    "Function f2 executed."
}

function f3
{
    "Function f3 executed."
}

$RestrictedFunctions = @('f1', 'f3')
# $AllowedFunctions = $env:FunctionUser -eq 'Admin' ? @('f1', 'f2', 'f3') : $RestrictedFunctions
$AllowedFunctions = $Mode -eq 'Admin' ? @('f1', 'f2', 'f3') : $RestrictedFunctions

Export-ModuleMember -Function $AllowedFunctions