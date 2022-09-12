<#
 .Synopsis
 Abfrage der Typ-Information
#>

# Server-Typ laden
using module .\TB11_ServerClass.psm1

$S1 = [Server]::new("Server123")

# Hole das RuntimeType-Objekt
$S1.GetType()

# Gibt den vollständigen Typennamen aus
$S1.GetType().FullName

# Ausgabe aller Members
$S1.GetType().GetMembers().Name