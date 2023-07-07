<#
 .SYNOPSIS
 Beispiel für das Anlegen eines Symlink
#>

if (-not (Get-Item -Path Posh))
{
    New-Item -Path Posh -Target $PsHome -Itemtype SymbolicLink -Verbose

}

Get-ChildItem -Path Posh