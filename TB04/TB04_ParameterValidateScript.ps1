<#
 .Synopsis
 Parameter-Validierung mit ValidateScript
#>

function test
{
    param([ValidateScript({$_ -eq "Windows"})][String]$OS)
    "OS=$OS"
}

test Windows

test -OS Linux
