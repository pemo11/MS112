

$h = @{}
$o1 = [PSCustomObject]@{p1=100}
$o2 = [PSCustomObject]@{p1=200}
$h.1 = $o1
$h.2 = $o2.psobject.Copy()

$h[1].p1 = 111
$h[2].p1 = 222

$o1
$o2

[object] | Get-Member | Where-Object {$_.Name -like "*clone*"}
