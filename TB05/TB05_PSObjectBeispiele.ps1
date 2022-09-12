<#
 .Synopsis
 Beispiel für psobject
#>

using module .\TB11_ServerClass.psm1

$S1 = [Server]::new("Server ABC")

# Die Namen aller Properties ausgeben
$S1.psobject.Properties.Name

# Es geht aber auch anders
$S1.GetType().GetProperties().Name

# Oder
$S1.GetType().GetProperties().ForEach{"Property > $($_.Name)"}