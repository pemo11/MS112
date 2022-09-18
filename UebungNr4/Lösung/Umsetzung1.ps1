<#
 .Synopsis
 Eine mögliche Umsetzung zur Übung Nr. 4
#>

class Server
{
    [String]$Name
    [UserAccount[]]$Users

    Server([String]$Name)
    {
        $this.Name = $Name
    }
}

class UserAccount
{
    [String]$Name

    UserAccount([String]$Name)
    {
        $this.Name = $Name
    }
}

$Katalog = @{}
$S1 = [Server]::New("Server1")
$Katalog[$S1.Name] = $S1

$UA1 = [UserAccount]::new("User1")
$UA2 = [UserAccount]::new("User2")
$UA3 = [UserAccount]::new("User3")

$Katalog[$S1.Name].Users = $UA1,$UA2,$UA3

ForEach($Server in $Katalog.Keys)
{
 $Katalog.$Server
}
