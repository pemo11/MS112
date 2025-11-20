<#
 .SYNOPSIS
 Pester-Tests für eine Performance-Messung
#>

$psm1Path = Join-Path $PSScriptRoot "TB13_PerformanceMeasure.psm1"
Import-Module $psm1Path -Force

Describe "Performance Tests" {

    It "Measures time for a fast operation" {
        $elapsed = Invoke-Operation -Operation { Get-Random } -OperationName "Fast Operation"
        $elapsed.TotalMilliseconds | Should -BeLessThan 100
    }

    It "Measures time for a slow operation" {
        $elapsed = Invoke-Operation -Operation { Get-Random } -SlowdownSeconds 2 -OperationName "Slow Operation"
        $elapsed.TotalSeconds | Should -BeLessThan 1.5
    }
}   

