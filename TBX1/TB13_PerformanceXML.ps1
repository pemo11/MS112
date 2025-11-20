<#
 .SYNOPSIS
 Auswerten einer WinSAT System-Bewertung und Anzeigen des XML-Ergebnisses
#>

$XmlPath = "C:\Windows\Performance\WinSAT\DataStore\2025-11-20 11.02.08.723 Formal.Assessment (Recent).WinSAT.xml"

[XML]$WinSatData = Get-Content $XmlPath
$WinSatData.WinSAT.Metrics.CPUMetrics.CompressionMetric.'#text'