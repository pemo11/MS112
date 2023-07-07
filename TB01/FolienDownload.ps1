<#
 .SYNOPSIS
 Download des aktuellen Foliensatzes vom Ftp-Server
#>

$FtpUsername = "ftp12146773-pskurs"
$FtpPwClear = "posh2021" | ConvertTo-SecureString –AsPlainText -Force
$FtpCred = [PSCredential]::New($FtpUsername, $FtpPwClear)
$FtpUri = "http://wp12146773.server-he.de/posh/MS112.zip"
$DownloaFolder = "C:\Temp\Ms112.zip"
Invoke-WebRequest -Uri $FtpUri -Credential $FtpCred -OutFile $DownloadFolder -AllowUnencryptedAuthentication