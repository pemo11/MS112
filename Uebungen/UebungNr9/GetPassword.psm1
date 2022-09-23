<#
 .SYNOPSIS
 Enthält die Function Get-Password
#>

<#
 .SYNOPSIS
 Erzeugt ein Passwort mit einer vorgegebenen Stärke
#>
function Get-Password
{
    param([Int]$Strength = 8)
    $Zeichen = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!§$%&/()=?`´*+~#'-_.:,;<>|"
    # PowerShell 7: Join-String-Cmdlet
    ($Zeichen.ToCharArray() | Get-Random -Count $Strength) -join ""
}