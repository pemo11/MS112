<#
 .SYNOPSIS
 Definition einer Klasse mit Hidden und sichtbaren Eigenschaften
#>

class Server
{
    Hidden[String]$SecretKey
    [String]$Name

    Hidden[Void]SetSecretKey([String]$key)
    {
        $this.SecretKey = $key
    }

    Hidden [String]GetSecretKey()
    {
        return $this.SecretKey
    }
}

$s1 = [Server]::new()
$s1.Name = "Server01"
# $s1 | Get-Member -MemberType Properties -Force
$s1 | Get-Member -MemberType Methods # -Force

$s1.SetSecretKey("TopSecret")
$s1.GetSecretKey()