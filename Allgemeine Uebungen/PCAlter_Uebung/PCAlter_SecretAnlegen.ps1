<#
 .Synopsis
 Anlegenn eines Secret für die Ablage des Kennworts
#>

#require -Modules Microsoft.PowerShell.SecretManagement
#require -Modules Microsoft.PowerShell.SecretStore

# Schritt 1: Eine SecretStore-Konfiguration anlegen

# Das Passwort ist optional, aber sicher sinnvoll - es muss von "irgenwdwoher" kommen
# In diesem Beispiel gibt es bereits die PCAlter.config-Datei mit dem Passwort als SecureString im Textformat

$ConfigPfad = Join-Path -Path $PSScriptRoot -ChildPath PCAlter.config
$Config = Import-PowerShellDataFile -Path $ConfigPfad
$StorePw = $Config.Password | ConvertTo-SecureString

# Ein Reset löst den Inhalt eines SecretStore
Reset-SecretStore -Password $StorePw -Force

# Set-SecretStoreConfiguration -Authentication Password -Scope CurrentUser -Interaction None -Password $StorePw -Confirm:$False
Set-SecretStoreConfiguration -Interaction None -Confirm:$False

# Schritt 2: Einen SecretVault anlegen

Get-SecretVault | Unregister-SecretVault -Verbose

Get-SecretVault

# Name ist beliebig, VaultParameters optional
Register-SecretVault -Name LocalStore -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault 

Get-SecretVault -Name LocalStore

# Schritt 3: Ein SecureString als Secret anlegen
Set-Secret -Name PCAlter -Secret "posh2021"

# Secret SecureString abrufen
Get-Secret -Name PCAlter

# Secret als Text abrufen
Get-Secret -Name PCAlter -AsPlainText
