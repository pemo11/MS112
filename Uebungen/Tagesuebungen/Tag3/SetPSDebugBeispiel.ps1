<#
 .SYNOPSIS
Ein einfaches PowerShell-Skript zur Demonstration von Debugging-Techniken.  
#>

# Aktivieren des Debuggers
Set-PSDebug -Trace 1    

# Funktion zur Berechnung der Summe von zwei Zahlen
function Add-Numbers {
    param (
        [int]$a,
        [int]$b
    )
    return $a + $b
}

# Hauptskript
$a = 5
$b = 10 
$result = Add-Numbers -a $a -b $b
Write-Host "Die Summe von $a und $b ist $result"
# Deaktivieren des Debuggers
Set-PSDebug -Off