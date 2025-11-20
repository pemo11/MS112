<#
 .Synopsis
 Pester-Teste mit Mock-Command
#>

BeforeAll {
    # Das zu mockende Command muss existieren, da ansonsten kein
    # Mock gebaut werden kann - es muss aber nicht ausführbar sein
    function New-AzADUser
    {
        [CmdletBinding()]
        param([String]$Username)
        throw "!!! Noch nicht fertigestellt !!!"
        Write-Verbose "*** AzureAD-Account für $Username wurde angelegt ***"
    }
}

Describe "Create AD-Users" {

    BeforeEach {
        Mock -CommandName New-AzADUser { return $true }
    }

    It "creates a new Azure AD user" {
        New-AzADUser -Username "User123" -Verbose | Should -Be $true
    }
}