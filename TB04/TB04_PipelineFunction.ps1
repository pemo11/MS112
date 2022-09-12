<#
 .Synopsis
 Beispiel für eine Pipeline-Function
#>
enum ServerMode
{
    Running
    Stopped
}

class Server
{
    [String]$Name
    [ServerMode]$Status

    Server([String]$Servername)
    {
        $this.Name = $ServerName
        $this.Status = "Stopped"
    }

    [void]SetStatus([ServerMode]$Status)
    {
        $this.Status = $Status
    }
}

$ServerListe = @([Server]::new("Server1"), [Server]::new("Server2"), [Server]::new("Server3"))

function Start-Server
{
    param([Parameter(ValueFromPipeline=$true)][Server[]]$Server)
    process
    {
        $_.SetStatus("Running")
        Write-Verbose "Server-Status changed to $($_.Status)"
    }
}

$ServerListe

$ServerListe | Start-Server -Verbose

$ServerListe