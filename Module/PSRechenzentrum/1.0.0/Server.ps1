<#
 .SYNOPSIS
 Definition der Klasse Server
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