<#
 .SYNOPSIS
    SSH-Remoting mit using: 
#>

$IPAdresse = "139.59.146.0"
$Username = "pemo"

$LimitKB = 1000

$SB = {
    Write-Host "Hallo vom Remote-Host!" -ForegroundColor Green
    Write-Host "Prozesse mit weniger als $using:LimitKB KB Arbeitsspeicher:" -ForegroundColor Yellow
    Get-Process | Where-Object { ($_.WS / 1KB) -lt $using:LimitKB } |
      Format-Table Name, Id, @{Name="WorkingSet(KB)";Expression={ [Math]::Round($_.WS / 1KB, 2) }} -AutoSize
    Return 1234
}

$Ps1Path = Join-Path -Path $PSScriptRoot -ChildPath "RemoteScriptParam.ps1"
$Ps1Code | Out-File -FilePath $Ps1Path -Encoding UTF8

$S1 = New-PSSession -HostName $IPAdresse -UserName $Username
$Result = Invoke-Command -Session $S1 -ScriptBlock $SB
$RetCode = $Result[-1]
Write-Host "Rückgabewert des Remote-Skripts: $RetCode"
$Result[0..($Result.Count - 2)]  # Alle bis auf den letzten Eintrag anzeigen
Get-PSSession | Remove-PSSession -Verbose