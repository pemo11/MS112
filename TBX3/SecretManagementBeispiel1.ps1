<#
 .Synopsis
 Kennwort per SecretManagement Modul abspeichern
 .NOTES
 install-module Microsoft.PowerShell.SecretManagement -Force -> Version 1.1.2
 install-module Microsoft.PowerShell.SecretStore -Force -> Version 1.0.6
#>

#requires -modules Microsoft.PowerShell.SecretManagement
#requires -modules Microsoft.PowerShell.SecretStore

# Schritt 1: Vault registrieren
try {
    Register-SecretVault -Name SecretStore -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault 
    Write-Host "Registriere Vault 'SecretStore'..." -ForegroundColor Green
} catch {
    Write-Host "Vault 'SecretStore' ist bereits registriert." -ForegroundColor Yellow
}

# Schritt 2: SecureString einlesen
$PwSec = Read-Host -Prompt "Pw?" -AsSecureString

# Schritt 3: Secret abspeichern
# Beim ersten Mal ist eine Passwort-Eingabe für den Vault erforderlich (demo+123)
Set-Secret -Name PwSec -Secret $PwSec -Vault SecretStore

# Schritt 4: Vault-Informationen anzeigen
Get-SecretVault -Name SecretStore

# Schritt 5: Vault testen
Test-SecretVault -Name SecretStore