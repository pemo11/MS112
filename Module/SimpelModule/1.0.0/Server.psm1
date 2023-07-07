<#
 .SYNOPSIS
 Definition of the Server class
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

    Server([String]$ServerName)
    {
        $this.Name = $ServerName
        $this.Status = [ServerStatus]::Undefined
    }
}