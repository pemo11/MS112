<#
 .Synopsis
 Kennwort per SecretManagement Modul abspeichern
 .NOTES
 install-module Microsoft.PowerShell.SecretManagement -Force -> Version 1.1.2
 install-module Microsoft.PowerShell.SecretStore -Force -> Version 1.0.6
#>

#requires -modules Microsoft.PowerShell.SecretManagement
#requires -modules Microsoft.PowerShell.SecretStore

# Schritt 1: PSCredential-Objekt erstellen
$PSCred = Get-Credential -Message "Bitte Anmeldeinformationen eingeben"

# Der Vault wurde bereits in Beispiel1 registriert

# Schritt 2: Secret speichern
Set-Secret -Name Credential1 -Secret $PSCred -Vault SecretStore

# Variable leeren
$PSCred = $Null

# Schritt 3: Secret abrufen
$PSCred = Get-Secret -Name Credential1 -Vault SecretStore

# Schritt 4: Anmeldeinformationen anzeigen
Write-Host "Benutzername: $($PSCred.UserName)" -ForegroundColor Green

# Passwort als Klartext anzeigen (nur zu Demo-Zwecken!)
# Geht auch nur auf dem Computer, auf dem das Secret abgespeichert wurde mit dem gleichen Benutzerkonto!
$Bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($PSCred.Password)
$UnsecurePassword = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($Bstr)
Write-Host "Passwort: $UnsecurePassword" -ForegroundColor Yellow    