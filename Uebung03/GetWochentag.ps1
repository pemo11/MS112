<#
 .Synopsis
 Objekt-Erweiterung über Select-Object und eine Hashtable
 .Notes
 @{n="Name der Eigenschaft";e={Wert der Eigenschaft}}
 für den Schlüssel n kann auch l oder label oder name eingesetzt werden
#>

# Was muss für Wochentag eingesetzt werden?
# Wochentag-Bestimmung über die CreationTime-Eigenschaft
# z.B. CreationTime.ToString("dddd")
Get-ChildItem -Path *.Ps1 | Select-Object Path,Length, Wochentag