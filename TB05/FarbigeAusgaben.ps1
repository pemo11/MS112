<#
 .SYNOPSIS
 Typ-Erweiterung für Farbige Ausgaben
#>

$TypeXml = @'
<Types>
    <Type>
        <Name>System.Diagnostics.Process</Name>
        <Members>
            <ScriptProperty>
                <Name>Laufzeit</Name>
                <GetScriptBlock>
                    $Esc = [Char]27
                    if (((Get-Date) - ($this.StartTime)).Hours -gt 1)
                    {
                        "$Esc[31m$($this.StartTime)$Esc[0m"
                    }
                    else
                    {
                        "$Esc[32m$($this.StartTime)$Esc[0m"
                    }
                </GetScriptBlock>
            </ScriptProperty>
        </Members>
    </Type>
</Types>
'@

# Erweiterung muss ps1xml sein
$TypeXmlPath = Join-Path -Path $PSScriptRoot -ChildPath ProcessType.ps1xml
$TypeXml | Set-Content -Path $TypeXmlPath

Update-TypeData -AppendPath $TypeXmlPath 
