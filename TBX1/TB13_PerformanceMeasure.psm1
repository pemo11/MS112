<#
 .SYNOPSIS
 Allgemeine Functions, die für einen Performance-Messung genutzt werden können
#>

function Start-MeasureTime {
    $script:stopwatch = [System.Diagnostics.Stopwatch]::new()
    $script:stopwatch.Start()
}

function Stop-MeasureTime {
    $script:stopwatch.Stop()
    return $script:stopwatch.Elapsed
}

function Show-MeasureTime {
    param (
        [string]$Message = "Dauer"
    )
    $elapsed = Stop-MeasureTime
    Write-Host "$Message`: $($elapsed.TotalSeconds) Sekunden" -ForegroundColor Yellow
}

function Invoke-Operation
{
    param (
        [scriptblock]$Operation,
        [string]$OperationName = "Operation",
        [int]$SlowdownSeconds = 0
    )

    Start-MeasureTime
    if ($SlowdownSeconds -gt 0) {
        Start-Sleep -Seconds $SlowdownSeconds
    }
    # & $Operation
    $Operation.Invoke()
    $result = Stop-MeasureTime
    Show-MeasureTime -Message $OperationName
    return $result
}