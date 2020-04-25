<# 
 .Synopsis
 Beispiel für eine Typ-Erweiterung
#>

# Ziel: Der Typ Server nachträglich soll eine Laufzeit-Eigenschaft erhalten
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

$TypeXml = @'
<Types>
    <Type>
        <Name>Server</Name>
        <Members>
            <ScriptProperty>
                <Name>Laufzeit</Name>
                <GetScriptBlock>
                     ((Get-Date)-$this.Startzeit).TotalSeconds
                </GetScriptBlock>
            </ScriptProperty>
        </Members>
    </Type>
</Types>
'@

# Erweiterung muss ps1xml sein
$TypeXmlPath = Join-Path -Path $PSScriptRoot -ChildPath ServerType.ps1xml
$TypeXml | Set-Content -Path $TypeXmlPath

Update-TypeData -AppendPath $TypeXmlPath 

$S1 = [Server]::new("Server123")
$S1
