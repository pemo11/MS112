<#
 .Synopsis
 Pester-Teste mit Mock-Command
#>

# Das zu mockende Command muss existieren, da ansonsten kein
# Mock gebaut werden kann - es muss aber nicht ausführbar sein

function New-AzADUser
{
    [CmdletBinding()]
    param([String]$Username)
    throw "!!!Noch nicht fertigestellt!!!"
    Write-Verbose "*** AzureAD-Account für $Username wurde angelegt ***"
}
describe "Create AD-Users" -Fixture {

    # Mock -CommandName New-AzADUser { return $true}

    it "creates a new Azure AD user" -test {
        New-AzADUser -Username "User123"  | Should be $true
    }
}