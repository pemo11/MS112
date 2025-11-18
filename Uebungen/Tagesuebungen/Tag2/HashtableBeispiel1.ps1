<#
 .SYNOPSIS
 Beispiel für eine Hashtable in PowerShell
#>

$h = [Ordered]@{}

for($m=1;$m -le 12;$m++)
{
    $h[(Get-Date -Month $m -Format MMMM)] = [DateTime]::DaysInMonth(2025, $m)
}

$h.GetEnumerator() | ForEach-Object {
    "$($_.Key): $($_.Value) Tage"
}