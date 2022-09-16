<#
 .Synopsis
 Definition der Klasse PSRechenzentrum
 .Notes
 Das Modul PSRechenzentrum im Ordner Module zeigt eine etwas bessere Umsetzung
 #>

 # Pfad muss angepasst werden, kann auch relativ sein - leider keine Variable möglich, da es der erste Befehl sein muss

using module G:\2022\Trainings\MS112\MS112-Repo\UebungNr7\SpezialServer.psm1

class PSRechenzentrum
{
    [SpezialServer[]]$ServerListe

    PSRechenzentrum()
    {
        $this.ServerListe = @()
    }

    [void]AddServer([SpezialServer]$Server)
    {
        $this.ServerListe += $Server
    }

    [void]NewServer([String]$Name, [String]$Description)
    {
        $Server = [SpezialServer]::new($Name, $Description)
        $this.ServerListe += $Server
    }
}