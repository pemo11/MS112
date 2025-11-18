<#
 .SYNOPSIS
 Beispiel für Parameter Splatting in PowerShell
#>

function Get-Sum
{
    param(
        [int]$A,
        [int]$B,
        [int]$C
    )

    return $A + $B + $C
}

function Get-Sum2
{
    param(
        [int]$A,
        [int]$B,
        [int]$C,
        [int]$D
    )

    return $A + $B + $C + $D
}

$Params = @{
    A = 10
    B = 20
    C = 30
}

Get-Sum2 @Params -C 50