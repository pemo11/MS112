# Registrieren des Repositories und Installieren des Moduls
if (-not (Get-PSRepository -Name "PoshRepo" -ErrorAction SilentlyContinue)) {
    Register-PSRepository -Name PoshRepo -SourceLocation "https://www.myget.org/F/poshrepo/api/v2"
}
Install-Module -Name Poshkurs -Repository PoshRepo -Scope CurrentUser -Force
$JsonPath = Join-Path -Path "~" -ChildPath "ComputerKonten.json"
Get-Computerkonten -Anzahl 1000 | Select-Object Name, LastBootTime, @{n="PSComputername";e={hostname}} | 
 ConvertTo-Json -Depth 3 | Out-File -FilePath $JsonPath -Encoding UTF8
Write-Host "1000 Computerkonten in Datei $JsonPath gespeichert." -ForegroundColor Green
Get-Content -Path $JsonPath | ConvertFrom-Json | Select-Object -First 5 | Format-Table -AutoSize
