<#
 .Synopsis
 Beispiel für SupportsShouldProcess mit Remove-Item
#>

function Test-Confirm
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    param()
    New-Item -Name Test.dat -ItemType File | Out-Null
    "Test.dat" | Remove-item
}

Test-Confirm -Confirm