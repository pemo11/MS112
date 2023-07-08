<#
 .Synopsis
 Testet die Funktion PasswordGenerator
#>

#requires -module @{modulename="pester";moduleversion="5.1"}

$Psm1Path = Join-Path -Path $PSScriptRoot -ChildPath "PasswordModul.psm1"
Import-Module -Name $Psm1Path -Force

<#
$Pw = Get-Password -length 4
if ($Pw.length -eq 4) { "Alles OK!"}
$Pw = Get-Password -length 10 
if ($Pw.length -eq 10) { "Alles OK!"}
$Pw = Get-Password -length 0
if ($Pw.length -eq 0) { "Alles OK!"}
#>


Describe "Passwort-Generator-Tests" {

    it "Testet die Funktion Get-Password" {
        $Pw = Get-Password -length 4
        $Pw.length | Should -Be 4
    }

    it "Testet die Funktion Get-Password" {
        $Pw = Get-Password -length 10
        $Pw.length | Should -Be 10
    }

    it "Testet die Funktion Get-Password mit dem Wert 0" {
        $Pw = Get-Password -length 0
        $Pw.length | Should -Be 0
    }

    it "Testet die Funktion Get-Password mit einem negativen Wert" {
        $Pw = Get-Password -length -1
        $Pw.length | Should -Be 0
    }

    it "Testet die Funktion Get-Password mit dem SpecialChar-Parameter" {
        $Pw = Get-Password -length 4 -SpecialChar
        $Pw[0] -in 33..47 | Should -Be $true
    }

}