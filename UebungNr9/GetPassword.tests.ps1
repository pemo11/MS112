<#
 .Synopsis
 Pester-Tests für die Get-Password Function
#>

#requires -modules @{modulename="Pester";RequiredVersion="5.1.1"}

$Psm1Path = Join-Path -Path $PSScriptRoot -ChildPath GetPassword.psm1

Import-Module -Name $Psm1Path -Force

describe "Testing Password-Generator" {

    it "generates a 8 char password" {
        (Get-Password -Strength 8).Length | Should -be 8
    }

    it "generates a 8 char password" {
        (Get-Password).Length | Should -be 8
    }

}