<#
 .SYNOPSIS
 Suche in einem sehr großen Array/Hashtable
#>

#requires -Module @{ModuleName="Poshkurs";ModuleVersion="1.2.0"}

$Accounts = Get-Computerkonten -Count 100000

$h = @{}
$i = 0 
foreach($acct in $Accounts)
{
    $h[$i++] = $acct
}

$SearchId = "PC-005"
$Ts1 = (Measure-Command -Expression {
    #$resultArray = $Accounts | Where-Object { $_.AccountId -eq $SearchId }
    $resultArray = $Accounts.Where{ $_.AccountId -eq $SearchId }
}).TotalSeconds

$Ts2 = (Measure-Command -Expression {
    $resultHash = $h[$SearchId]
}).TotalSeconds

"Suchdauer im Array: {0:n6}s" -f $Ts1
"Suchdauer in der Hashtable: {0:n6}s" -f $Ts2
"Geschwindigkeitsvorteil Hashtable: {0:n2}x" -f ($Ts1 / $Ts2)
