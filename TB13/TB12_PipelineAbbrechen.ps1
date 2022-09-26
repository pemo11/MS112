<#
 .Synopsis
 Vorzeitiges Abbrechen der Pipeline
#>

#requires -Modules @{ModuleName="poshkurs";RequiredVersion="1.2.0"}

Get-Computerkonten -Limit 1000 | Select-Object -First 10
