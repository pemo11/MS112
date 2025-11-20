<#
 .SYNOPSIS
 Beispiel 3 mit SecretManagement: Einen Prozess mit anderen Benutzeranmeldeinformationen starten
#>

<#
$Username = "poshuser"
$PwSec = "demo+123" | ConvertTo-SecureString -AsPlainText -Force
$Cred = [PSCredential]::new($Username, $PwSec)
Set-Secret -Name PoshUserCred -Secret $Cred -Vault SecretStore
#>

$Cred = Get-Secret -Name PoshUserCred -Vault SecretStore

$WorkDir = "C:\Temp"
# Bei Verwendung von -Credential muss auch ein Arbeitsverzeichnis angegeben werden!
Start-Process -FilePath "pwsh" -Credential $Cred -WorkingDirectory $workDir `
 -ArgumentList "-NoExit", "-Command", "cls;whoami" 

