<#
 .Synopsis
 Parameter-Validierung mit ValidateSet
#>

function test
{
    param([ValidateSet("MacOS","Linux","Windows")][String]$OS)
    "OS=$OS"
}

test -OS Linux

test "1234"