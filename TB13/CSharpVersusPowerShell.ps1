<#
 .SYNOPSIS
 Vergleich Einlesen einer großen Xml-Datei per C# StreamReader vs. PowerShell
#>

# Große Datei mit der C# Methode einlesen
$dllPath = Join-Path $PSScriptRoot "LargeFileReader.dll"
Add-Type -Path $dllPath

$largeFilePath = "C:\Users\qskills\Documents\ms112A\Material\PerfData-Servers.xml"
# $largeFilePath = "R:\PerfData-1000Servers.xml"

function Measure-CommandSafe {
    param([ScriptBlock]$ScriptBlock)
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    try {
        $ScriptBlock.Invoke()
        $stopwatch.Stop()
        return $stopwatch.Elapsed.TotalSeconds
    } catch {
        Write-Warning "Fehler beim Ausführen des Scriptblocks $($_.Exception.Message)"
        $stopwatch.Stop()
        return -1
    }
}

$t1 = Measure-CommandSafe {
    $Content = Get-Content -Path $largeFilePath -Raw
    [void]([Xml]$Content).PerformanceLog.Server
}

$t2 = Measure-CommandSafe {
    $Sr = [System.IO.StreamReader]::new($largeFilePath)
    $Content = $Sr.ReadToEnd()
    [void]([Xml]$Content).PerformanceLog.Server
    $Sr.Close()
}

$t3 = Measure-CommandSafe {
    $Content = [LargeFileReader]::ReadFile($largeFilePath)
    [void]([Xml]$Content).PerformanceLog.Server
}

Write-Host "PowerShell Get-Content Zeit: $t1 Sekunden" -ForegroundColor Yellow
Write-Host "C# StreamReader Zeit: $t2 Sekunden" -ForegroundColor Green
Write-Host "C# LargeFileReader Zeit: $t3 Sekunden" -ForegroundColor Cyan
Write-Host "Vergleich abgeschlossen."