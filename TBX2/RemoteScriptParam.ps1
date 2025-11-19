param (
    [Parameter(Mandatory=$true)][Int]$LimitKB
)
    Write-Host "Hallo vom Remote-Host!" -ForegroundColor Green
    Write-Host "Prozesse mit weniger als $LimitKB KB Arbeitsspeicher:" -ForegroundColor Yellow
    Get-Process | Where-Object { ($_.WS / 1KB) -lt $LimitKB } |
      Format-Table Name, Id, @{Name="WorkingSet(KB)";Expression={ [Math]::Round($_.WS / 1KB, 2) }} -AutoSize
