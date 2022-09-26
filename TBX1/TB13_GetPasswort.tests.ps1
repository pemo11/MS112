<#
 .Synopsis
 Ein Test für die Get-Passwort-Function
 .Notes
 https://pester.dev/docs/usage/assertions
 https://github.com/pester/Pester/wiki/Should-v3
#>

#requires -modules pester

import-module ./TB13_PassswortGenerator.psm1

describe "Testing Password-Generator" {

    it "generates a 8 char password" {
        (Get-Passwort).Length | Should be 8
    }

    it "generates a 1 char password" {
        (Get-Passwort -Staerke 1).Length | Should be 1
    }

    it "tests if first char is number" {
        $pw = Get-Passwort -StartWithNumber
        # Wird eine Ausnahme, wenn das erste Zeichen keine Ziffer ist
        {[Int]::Parse($pw[0].ToString())} | Should not Throw "Input string was not in a correct format"
        # {throw "Bla"} | Should Throw "Bla"
        # Es kommt auf die Fehlermeldung an!
        #{0/0} | Should Throw "Attempted to divide by zero"
    }

    # -StartWithNumber muss noch implementiert werden
}