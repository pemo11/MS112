<#
 .SYNOPSIS
 Beispiel für den Test der Code-Adeckung mit Pester und die Ausgabe der Ergebnisse im XML-Format
#>

#requires -modules @{ModuleName='Pester';ModuleVersion='5.0.0'}

$psm1Path = Join-Path $PSScriptRoot "CodeCoverageModule.psm1"
Import-Module $psm1Path -Force

Describe "Code Coverage Tests" {

    It "Tests the f1 function" {
        f1 | Should -be "Funktion f1 wurde aufgerufen."
    }

    It "Tests the f2 function" {
        f2 | Should -be "Funktion f2 wurde aufgerufen."
    }
    
}