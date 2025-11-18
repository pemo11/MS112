<#
 .SYNOPSIS
 Einfaches NLog Beispiel in PowerShell
#>

# NLog Assembly laden
$nlogPath = "$env:LOCALAPPDATA\PackageManagement\NuGet\Packages\NLog.6.0.6\lib\netstandard2.0\NLog.dll"
Add-Type -Path $nlogPath

# Konfiguration erstellen
$config = [NLog.Config.LoggingConfiguration]::new()

# File Target
$fileTarget = [NLog.Targets.FileTarget]::new()
$fileTarget.FileName = "C:\Temp\mylog.txt"
$fileTarget.Layout = '${longdate} ${level} ${message}'

# Target hinzufügen
$config.AddTarget("file", $fileTarget)

# Logging Rule (alles ab Info-Level)
$rule = [NLog.Config.LoggingRule]::new("*", [NLog.LogLevel]::Info, $fileTarget)
$config.LoggingRules.Add($rule)

# Konfiguration aktivieren
[NLog.LogManager]::Configuration = $config

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
