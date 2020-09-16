<#
 .Synopsis
 Verarbeiten von CSV-Dateien
#>

$CsvPfad1 = Join-Path -Path $PSScriptRoot -ChildPath Report1.csv
$CsvPfad2 = Join-Path -Path $PSScriptRoot -ChildPath Report2.csv

$Daten1 = Import-CSV -Path $CsvPfad1
$Daten2 = Import-CSV -Path $CsvPfad2


# $Daten1 | Format-Table

# $Daten2 | Format-Table

enum Serverstatus
{
    OK
    Error
    Undefined
}

class Server
{
    [String]$Computername
    [Serverstatus]$Status
    [DateTime]$LastBootTime

    Server([String]$Computername, [Serverstatus]$Status, [DateTime]$LastBootTime)
    {
        $this.Computername = $Computername
        $this.Status = $Status
        $this.LastBootTime = $LastBootTime
    }
}

$ServerListe = @()

foreach($Server in $Daten1)
{
    $ServerListe += [Server]::new($Server.Server, $Server.Status, $Server.LastBoot)
}

foreach($Server in $Daten2)
{
    $ServerListe += [Server]::new($Server.Computername, $Server.Status, $Server.LastBoot)
}


$ServerListe | Where-Object Status -eq "Error"

