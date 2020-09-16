
function Get-Speicherkosten
{
<#
 .Synopsis
 Berechnen von Speicherkosten
 .Description
 Speicherkosten anhand des belegten Speicherplatzes
#>
    [CmdletBinding(DefaultParametersetName="*")]
    param([Parameter(ValueFromPipelineByPropertyName=$true)][Alias("FullName")][String]$Path,
     [Double]$KostenMB=0.25,
     [Parameter(ParametersetName="HtmlOutput", Mandatory=$true)][Switch]$Html,
     [Parameter(ParametersetName="HtmlOutput")][String]$HtmlFilePath)

    process
    {
        $Summe = 0;
        $Startzeit = Get-Date;
        Get-ChildItem -File -Recurse -Path $Path | ForEach-Object {
            $Summe += $_.Length
        }

        $obj = [PSCustomObject]@{Pfad=$Path
          Kosten= [Math]::Round($Summe / 1MB * $KostenMB, 2)
        }
        $obj

        $Dauer = ((Get-Date) - $Startzeit).TotalSeconds
        Write-Verbose ("*** Die Speicherkosten wurden in {0:n2}s berechnet ***" -f $Dauer)

        if ($Html)
        {
            $HtmlText = $obj | ConvertTo-Html
            Write-Host $HtmlText
            if ($PSBoundParameters.ContainsKey("HtmlFilePath"))
            {
                $HtmlText | Set-Content -Path $HtmlFilePath
            }
        }
    }
}

