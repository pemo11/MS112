<#
 .Synopsis
 Vorzeitiges Abbrechen der Pipeline
#>

#requires -Modules @{ModuleName="poshkurs";RequiredVersion="1.3.0"}

Get-UserInfo -Limit 1000 | Select-Object -First 10
