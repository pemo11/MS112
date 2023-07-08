<#
 .Synopsis
 Projekt PC-Alter-Abfrage
 .Notes
 Schritt 1: Ausgabe des CPU-Typs über eine WMI-Abfrage
#>

Get-CimInstance -ClassName Win32_Processor 

Get-CimInstance Win32_Processor | Select-Object Name 

Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name 