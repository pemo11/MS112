<#
 .SYNOPSIS
 Ein paar einfache Standardtests
#>

#requires -modules @{moduleName="pester";moduleVersion="5.0"}

# Direktes Laden sollte nicht erforderlich sein
using module PSRechenzentrum/1.0.0/Rechenzentrum.psm1
using module PSRechenzentrum/1.0.0/SpezialServer.psm1

$Psm1Path = Join-Path -Path $PSScriptRoot -ChildPath "PSRechenzentrum"
Import-Module -Name $Psm1Path -Force -Verbose


describe "Standardtests" {

    it "creates a datacenter " {
        $RZ = [Rechenzentrum]::New()
        $RZ | Should -not -be $null
    }

    it "creates a datacenter with one server " {
        $RZ = [Rechenzentrum]::new()
        $Server1 = [SpezialServer]::new("Server 1", "Nur eine Demo")
        $RZ.AddServer($Server1)
        $RZ.ServerListe.Count | Should -be 1
    }
}