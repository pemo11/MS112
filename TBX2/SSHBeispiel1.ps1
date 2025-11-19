<#
 .SYNOPSIS
 SSH-Remoting mit Passwort-Authentifizierung und Windows Server 2019
#>

# $HostName = "ubuntu1"
$IPAdresse = "139.59.146.0"
$Username = "pemo"
# Muss immer eingegeben werden, da Passwort nicht gespeichert wird
# Besser ist es, hier mit Public Key Authentifizierung zu arbeiten
# $HostPw = "demo+123"

# Verbindung mit Passwort-Authentifizierung herstellen
$S1 = New-PSSession -HostName $IPAdresse -UserName $Username
# Enter-PSSession -Session $S1

Invoke-Command -Session $S1 -ScriptBlock { Get-Process }
Invoke-Command -Session $S1 -ScriptBlock { whoami ; hostname }

Get-PSSession

Get-PSSession | Remove-PSSession -Verbose
