<#
 .SYNOPSIS
 Einen Prozess mit anderen Benutzeranmeldeinformationen starten
#>

$Username = "poshuser"
$PwSec = "demo+123" | ConvertTo-SecureString -AsPlainText -Force
$Cred = [PSCredential]::new($Username, $PwSec)

$WorkDir = "C:\Temp"
# Bei Verwendung von -Credential muss auch ein Arbeitsverzeichnis angegeben werden!
Start-Process -FilePath "pwsh" -Credential $Cred -WorkingDirectory $workDir `
 -ArgumentList "-NoExit", "-Command", "cls;whoami" 

 # Übung: Umstellen auf SecretManagement, so dass das Kennwort nicht im Skript steht!