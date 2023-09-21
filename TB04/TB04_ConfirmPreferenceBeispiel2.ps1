<#
 .Synopsis
 Beispiel für das Zusammenspiel von ConfirmImpact und ConfirmPreference
#>

function Remove-Number
{
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact="Medium")]
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

# Bei ConfirmPreference=High passiert nichts
$ConfirmPreference = "High"
Remove-Number $z1 $z2

$ConfirmPreference = "Medium"
Remove-Number $z1 $z2
