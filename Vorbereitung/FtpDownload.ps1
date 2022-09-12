<#
 .Synopsis
 Download der Zip-Datei mit den Beispielen und der PowerPoint-Folie per Ftp
#>

$FtpServer = "ftp://wp12146773.server-he.de"
$FileName = "posh/MS112.zip"
$FtpUsername = "ftp12146773-pskurs"
$FtpPassword = "posh2021"

$Cred = [PSCredential]::New($FtpUsername, ($FtpPassword | ConvertTo-SecureString -AsPlainText -Force))

Invoke-WebRequest -Uri "$FtpServer/$FileName" -Credential $Cred -OutFile PoshKurs.zip