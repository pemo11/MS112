<#
 .Synopsis
 Verwenden einer Klassendefinition aus einem anderen Modul
#>

# $PSScriptRoot = D:\temp\MS112

Using Module .\TB11_ServerClass.psm1

# $Psm1Pfad = Join-Path -Path $PSScriptRoot -ChildPath "TB11_ServerClass.psm1"

# Import-Module $Psm1Pfad

$s1 = [Server]::new("Server 1")
$s1

