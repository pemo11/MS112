<#
 .Synopsis
 Ein weiterer Pester-Test für die angepasste Get-Password-Function
#>

#requires -modules @{modulename="Pester";RequiredVersion="5.1.1"}

$Psm1Path = Join-Path -Path $PSScriptRoot -ChildPath GetPassword.psm1

Import-Module -Name $Psm1Path -Force

describe "Testing Password-Generator" {

    it "generates a password where the first char is a special character" {
        # Hier fehlt etwas
    }

}