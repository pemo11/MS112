<#
 .Synopsis
 Beispiel die Wirkung von SupportShouldProcess
#>

function Remove-Number
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    param([Int[]]$BaseArray, [Int[]]$RemoveArray)
    foreach($z in $RemoveArray)
    {
        if ($PSCmdlet.ShouldProcess("Element $z löschen?"))
        {
            $BaseArray = $BaseArray -ne $z
        }
    }
    $BaseArray
}

$z1 = 1..10
$z2 = 3,5,7

Remove-Number $z1 $z2 -Confirm
