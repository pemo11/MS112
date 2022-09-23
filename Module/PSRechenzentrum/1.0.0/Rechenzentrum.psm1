<#
 .Synopsis
 Definition der Klasse Rechenzentrum
#>

using module .\SpezialServer.psm1

class Rechenzentrum
{
    [SpezialServer[]]$ServerListe

    Rechenzentrum()
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