<#
 .Synopsis
 Ausgabe aller Klassen einer Assembly
#>

$AssTypen = Add-Type -AssemblyName System.Windows.Forms -PassThru

# Sortierte Ausgabe der Namen aller öffentlichen Klassen
$AssTypen.Where{$_.IsClass -and $_.IsPublic} | Sort-Object -Property Name | Select-Object Name,Namespace

# Klassennamen, die mit Dialog enden
$AssTypen.Where{$_.IsClass -and $_.IsPublic} | Where-Object Name -like "*Dialog" | Sort-Object -Property Name | Select-Object Name,Namespace
