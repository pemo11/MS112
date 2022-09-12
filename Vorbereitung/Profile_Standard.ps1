<#
 .Synopsis
 Eine Standard-Profilskriptdatei
#>

# PowerShell-Logging aktivieren mit Tagesdatum im Dateinamen

$TranscriptPath = "PSTranscript_$(Get-Date -Format yyyy-MM-dd).txt"
Start-Transcript -Path $TranscriptPath -Append 

# Verschiedene Verzeichnisse an die Path-Umgebungsvariable anhängen
$VerzeichListe = @("D:\Tools")
foreach($Verzeichnis in $VerzeichListe)
{
    # Nur hinzufügen, wenn Verzeichnis existiert und es nicht schon drin ist
    if (Test-Path -Path $Verzeichnis -and ($env:path -split ";") -notcontains $Verzeichnis)
    {
        $env:path += ";$Verzeichnis"
    }
}

# In das Documents-Verzeichnis wechseln
cd $env:USERPROFILE\Documents