<#
 .SYNOPSIS
 Führt WinSAT CPU-Bewertung aus und zeigt das XML-Ergebnis an
 .DESCRIPTION
 Ruft winsat.exe zur CPU-Bewertung auf und gibt das XML-Ergebnis zurück
 .EXAMPLE
 Get-CPUAssessment
 .EXAMPLE
 Get-CPUAssessment -ShowXml
#>

function Get-CPUAssessment
{
    [CmdletBinding()]
    param(
        [Switch]$ShowXml
    )
    
    # Prüfen ob als Administrator ausgeführt
    $isAdmin = ([Security.Principal.WindowsPrincipal] `
            [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administratoren")
    
    if (-not $isAdmin)
    {
        Write-Error "Diese Funktion erfordert Administrator-Rechte"
        return
    }
    
    Write-Host "Starte System-Bewertung mit WinSAT (kann einige Minuten dauern)..." -ForegroundColor Cyan
    
    # WinSAT formale Bewertung ausführen
    $result = winsat formal -restart clean
    
    if ($LASTEXITCODE -ne 0)
    {
        Write-Warning "WinSAT-Ausführung mit Exit Code: $LASTEXITCODE"
    }
    
    # XML-Datei suchen (neueste Datei im DataStore)
    $xmlPath = Get-ChildItem "C:\Windows\Performance\WinSAT\DataStore" -Filter "*Formal.Assessment*.xml" | 
    Sort-Object LastWriteTime -Descending | 
    Select-Object -First 1 -ExpandProperty FullName
    
    if (-not $xmlPath)
    {
        Write-Error "Keine WinSAT XML-Datei gefunden"
        return
    }
    
    Write-Host "XML-Datei gefunden: $xmlPath" -ForegroundColor Green
    
    # XML laden und anzeigen
    [xml]$xmlContent = Get-Content $xmlPath
    
    if ($ShowXml)
    {
        # Formatiertes XML ausgeben
        $stringWriter = New-Object System.IO.StringWriter
        $xmlWriter = New-Object System.Xml.XmlTextWriter($stringWriter)
        $xmlWriter.Formatting = "Indented"
        $xmlContent.WriteContentTo($xmlWriter)
        $xmlWriter.Flush()
        $stringWriter.Flush()
        Write-Output $stringWriter.ToString()
    }
    
    # CPU-Score extrahieren und anzeigen
    $cpuScore = $xmlContent.WinSAT.WinSPR.CpuScore
    $memoryScore = $xmlContent.WinSAT.WinSPR.MemoryScore
    $graphicsScore = $xmlContent.WinSAT.WinSPR.GraphicsScore
    $diskScore = $xmlContent.WinSAT.WinSPR.DiskScore
    
    Write-Host "`n=== WinSAT Bewertung ===" -ForegroundColor Yellow
    Write-Host "CPU Score:      $cpuScore" -ForegroundColor White
    Write-Host "Memory Score:   $memoryScore" -ForegroundColor White
    Write-Host "Graphics Score: $graphicsScore" -ForegroundColor White
    Write-Host "Disk Score:     $diskScore" -ForegroundColor White
    
    # Rückgabe des XML-Objekts
    return $xmlContent
}

# Funktion aufrufen
Get-CPUAssessment -ShowXml
