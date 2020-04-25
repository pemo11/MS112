<#
 .Synopsis
 Definition einer Klasse
#>

enum ServerStatus
{
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
        $this.Startzeit = Get-Date
    }
}
