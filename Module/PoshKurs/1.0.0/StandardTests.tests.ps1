<#
 .SYNOPSIS
 Ein paar Tests
#>

#requires -modules @{ModuleName="Pester";ModuleVersion="5.0.0"}

$Psm1Path = Join-Path -Path $PSScriptRoot -ChildPath "Poshkurs.psm1"
Import-Module -Name $Psm1Path -Force

describe "Csv tests" {

    it "Creates a csv file" {
        $CsvPath = Join-Path -Path $PSScriptRoot -ChildPath "Test1.csv"
        Remove-Item -Path $CsvPath -ErrorAction Ignore
        New-ADUserCSV -Path $CsvPath
        Test-Path -Path $CsvPath | Should -be $True
    }
}