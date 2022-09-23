<#
 .Synopsis
 Installiert ein Modul aus einem privaten Repository, das einige für die Schulung in Übungen verwendeten Funktionalitäten enthält
 .Notes
 Keine Voraussetzung, sondern lediglich eine Ergänzung
 Die Adresse des Package Feeds: https://www.myget.org/feed/Packages/poshrepo
#>

# Schritt 1: Registrieren der Repo-Adresse für den Abruf von Modulen - keine Credentials erforderlich, da es sich um ein öffentliches Repo handelt
Register-PSRepository –Name PoshRepo -SourceLocation https://www.myget.org/F/poshrepo/api/v2

# Schritt 2: Installation des Moduls aus dem registrierten Repo
Install-Module –Name Poshkurs -Repository PoshRepo

# Schritt 3: Auflisten der Commands aus dem neuen Modul
Get-Command -Module Poshkurs

