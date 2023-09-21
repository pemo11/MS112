<#
 .SYNOPSIS
 Beispiel für eine SSH-Session
#>

#requires -version 7.0

$Hostname = "165.227.148.64"
$Username = "root"

# Gibt leider aktuell einen Permission Denied Fehler aus - PasswortAuthentifizierung is no, da ich den KeyFilePath Parameter verwende
# Hat vielleicht tiefergehende Gründe, die ich nicht kenne

# $S1 = New-PSSession -HostName $Hostname -UserName $Username -SSHTransport -Subsystem powershell
$KeyPath = "C:\Users\pemo20\.ssh\id_ed25519"
# SSHTransport ist überflüssig, wenn der Hostname-Parameter verwendet wird und Subsystem ist immer powershell
$S1 = New-PSSession -HostName $Hostname -UserName $Username -KeyFilePath $KeyPath
if ($null -ne $S1)
{
    Enter-PSSession –Session $S1
}
