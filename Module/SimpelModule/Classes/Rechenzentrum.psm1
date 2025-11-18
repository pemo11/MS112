<#
 .SYNOPSIS
 Definition of the Rechenzentrum class
#>

using module .\Server.psm1

using namespace System.Collections.Generic

class Rechenzentrum
{

    [List[Server]] $Server

    Rechenzentrum()
    {
        $this.Server = @()
    }

    [void]AddServer([String]$ServerName)
    {
        $this.Server += [Server]::new($ServerName)
    }

    [String]ToString()
    {
        return "Server: $($this.Server | ForEach-Object { $_.Name })"
    }
}
