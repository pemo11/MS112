<#
 .SYNOPSIS
    This is a simple module containing class definitions for Server management
 .DESCRIPTION
    Provides classes for Server, SpezialServer and Rechenzentrum
#>

# Load classes in correct order (base class first)
using module .\Classes\Server.psm1
using module .\Classes\SpezialServer.psm1
using module .\Classes\Rechenzentrum.psm1

# Make classes available in caller's scope
$ExecutionContext.SessionState.Module.OnRemove = {
    Remove-Variable -Name Server, SpezialServer, Rechenzentrum -ErrorAction SilentlyContinue
}

# Export classes so they can be used when importing the module
Export-ModuleMember -Function @()
