<#
 .SYNOPSIS
 Definition der Klasse Server.psm1
#>

enum ServerStatus
{
    Running
    Stopped
    Undefined
}

class Server
{
    [ServerStatus]$Status
    [String]$Name
    [String]$Description
    [String]$Id

    Server()
    {
        $this.Status = [ServerStatus]::Undefined
    }
}