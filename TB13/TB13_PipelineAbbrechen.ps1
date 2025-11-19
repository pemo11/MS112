<#
 .Synopsis
 Vorzeitiges Abbrechen der Pipeline
#>

#requires -Modules @{ModuleName="poshkurs";RequiredVersion="1.2.0"}

Get-Computerkonten -Anzahl 10000 | Select-Object -First 10

Get-Computerkonten -Anzahl 10000 | Select-Object -Last 10
