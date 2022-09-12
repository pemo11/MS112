<#
 .Synopsis
 Projekt PC-Alter-Abfrage
 .Notes
 Schritt 9: Function soll auch als Teil einer Pipeline aufrufbar sein
 Gute Zusammenfassung von Boe Prox
 https://learn-powershell.net/2013/05/07/tips-on-implementing-pipeline-support/
#>

<#
 .Synopsis
 Abfrage des Alters einer CPU
 .Description
 Grundlage ist die Datei cpu.csv im Unterverzeichnis /material
 .Example
 Get-CPUData "Ryzen 9 3900X","Ryzen 9 5950X"
 #>
function Get-CPUData
{
     # aus String wird String[] - damit können beliebig viele Werte übergeben werden
     [CmdletBinding()]
     param([Parameter(ValueFromPipeline=$true, Mandatory=$true)][String[]]$CpuTyp)
     process
     {
         # Für den Fall erforderlich, dass der Name/die Namen dem Parameter direkt zugewiesen werden
         foreach($Typ in $CpuTyp)
         {
            Write-Verbose "Verarbeite $Typ"
            $CSVPfad = Join-Path -Path $PSScriptRoot -ChildPath "Material/cpu.csv"
            Import-CSV -Path $CSVPfad -Delimiter ";" | Where-Object {$Typ -like "*$($_.Name)*"} | 
                Select-Object -Property Manufacturer, Name, @{n="Datum";e={Get-Date -Date $_.CreateDate}}
         }
     }
}
 
$CPUTypen = @("AMD Ryzen 9 3900X 12-Core Processor","AMD Ryzen 9 5950X")
 
# Das Array wird automatisch dem Parameter CpuTyp zugeordnet
# $CPUTypen | Get-CPUData | Format-Table

# Format-Table sorgt dafür, dass eine neue Pipeline angelegt wird (ansonsten werden beide Ausgaben zusammengefasst)
# $CPUTypen | Get-CPUData  -Verbose | Format-Table

Get-CPUData -CpuTyp $CPUTypen[0]

# So geht es aber auch
# Get-CPUData -CpuTyp $CPUTypen  -Verbose
