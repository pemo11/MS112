

function f1
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    param([String]$Path)

    Write-Verbose "*** $Path soll nach D:\temp kopiert werden ***"
    Write-Verbose "*** $Path soll nach $env:temp kopiert werden ***"
    $VerboseMode = $PSBoundParameters.ContainsKey("Verbose")
    # Eine Abfrage von WhatIf und Confirm wird nicht gemacht
    # $WhatIfMode = $PSBoundParameters.ContainsKey("WhatIf")
    Copy-Item -Path $Path -Destination D:\temp -Verbose:$VerboseMode
    Copy-Item -Path $Path -Destination $env:temp -Verbose:$VerboseMode

}

f1 -Path C:\Windows\win.ini -Verbose # -WhatIf