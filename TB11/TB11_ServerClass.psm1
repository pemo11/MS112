<#
 .Synopsis
 Definition einer Klasse
#>

enum ServerStatus
{
    Uninitialized
    Running
    Stopped
}

# Typdefinition Server
class Server
{
    [String]$Name
    [ServerStatus]$Status
    [DateTime]$Startzeit

    Server([String]$Name)
    {
        $this.Name = $Name
        $this.Status = "Uninitialized"
        $this.Startzeit = Get-Date
    }
}

[Server]::new()