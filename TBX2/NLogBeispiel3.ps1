<#
 .SYNOPSIS
 NLog Beispiel mit XML-Konfigurationsdatei
#>

# NLog Assembly laden
$nlogPath = "$env:LOCALAPPDATA\PackageManagement\NuGet\Packages\NLog.6.0.6\lib\netstandard2.0\NLog.dll"
Add-Type -Path $nlogPath

# Konfiguration aus XML-Datei laden
$configFile = Join-Path $PSScriptRoot "NLog.config"
[NLog.LogManager]::Configuration = [NLog.Config.XmlLoggingConfiguration]::new($configFile)

# Logger erstellen
$logger = [NLog.LogManager]::GetLogger("MeinScript")

# Logging verwenden
$logger.Info("Script gestartet")
$logger.Warn("Dies ist eine Warnung")
$logger.Error("Dies ist ein Fehler")
$logger.Info("Script beendet")

# Aufräumen
[NLog.LogManager]::Shutdown()

Write-Host "Log-Datei: C:\Temp\mylog.txt" -ForegroundColor Green
Write-Host "Konfiguration geladen aus: $configFile" -ForegroundColor Cyan
