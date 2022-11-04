<#
 .Synopsis
 Kennwort per SecretManagement Modul abrufen
#>

#requires -modules Microsoft.PowerShell.SecretManagement

$Username = "qskills"
$PwSec = Get-Secret -Name PwSec
$Cred = [PSCredential]::new($Username, $PwSec)
Invoke-Command -ComputerName ES6101 -Credential $cred -ScriptBlock { hostname }


