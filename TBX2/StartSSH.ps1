<#
 .SYNOPSIS
 Beispiel für eine SSH-Session 
#>

#requires -version 7.0

$Hostname = "64.225.108.74"
$Username = "root"

$S1 = New-PSSession -HostName $Hostname -UserName $Username -SSHTransport -Subsystem powershell
Enter-PSSession –Session $S1
