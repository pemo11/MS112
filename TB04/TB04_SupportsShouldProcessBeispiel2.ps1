<#
 .Synopsis
 Explizite Bestätigung für eigene Aktionen
#>

using namespace System.Collections.Generic

class Server
{
    [String]$Name
    Server([String]$Servername)
    {
        $this.Name = $Servername
    }
}

<#
 .Synopsis
 Entfernt ein Serverobjekt aus der Liste
#>
function Remove-Server
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    param([Server]$Server)
    if ($PSCmdlet.ShouldProcess("Server $($Server.Name) löschen?"))
    {
        $Serverliste.Remove($Server)
    }
}

$S1 = [Server]::new("Server1")
$S2 = [Server]::new("Server2")
$ServerListe = [List[Server]]::new()
$ServerListe.Add($S1)
$ServerListe.Add($S2)

# Server wird ohne Rückfrage entfernt
Remove-Server $S1

# Server wird nicht entfernt
Remove-Server $S2 -WhatIf

# Server wird nur nach Rückfrage entfernt
Remove-Server $S2 -Confirm

$ServerListe