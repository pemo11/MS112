<#
 .SYNOPSIS
 Parametersets bei Functions und Skripten
#>

function Invoke-APIService
{
    [CmdletBinding(DefaultParameterSetName = "ByUrl")]
    param(
        [Parameter(Mandatory, ParameterSetName = "ByUrl")]
        [string]$Url,

        [Parameter(Mandatory, ParameterSetName = "ByUrl")]
        [string]$ApiKey,

        [Parameter(Mandatory, ParameterSetName = "ByFile")]
        [string]$FilePath,

        [Parameter()]
        [switch]$UseDefault1,

        [Parameter]
        [switch]$UseDefault2
    )
}

Get-Command -Name Invoke-APIService -Syntax 

Invoke-APIService -FilePath "C:\Temp\data.json" -