<#
 .Synopsis
 Projekt PC-Alter-Abfrage
 .Notes
 Tests für das Modul PCAlter.psm1
#>

# Mind. version 5.0 erforderlich
#requires -Modules @{ ModuleName="Pester"; ModuleVersion="5.0.0" }

$Psm1Pfad = Join-Path -Path $PSScriptRoot -ChildPath ..\1.0.0.0\PCAlter.psm1

Import-Module -Name $Psm1Pfad

Describe "Standardtest" {

    it "should return an object" {
        $Info = Get-CPUInfo -Computername Localhost
        $Info | Should -not -be $null
    }
}