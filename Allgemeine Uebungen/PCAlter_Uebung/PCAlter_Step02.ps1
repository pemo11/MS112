<#
 .Synopsis
 Projekt PC-Alter-Abfrage
 .Notes
 Schritt 2: Die Abfrage wird in eine Function eingebaut
 
 Da die Function  noch ohne Parameter verwendet wird, bleibt alles ganz einfach
#>

function Get-CPUTyp
{
    Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name 
}


Get-CPUTyp