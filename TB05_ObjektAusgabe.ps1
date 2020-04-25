<#
 .Synopsis
 Beispiel für eine Objektausgabe
#>

$ServerDaten = @'
Name,Startzeit
Server123,12:30
Server456,14:30
ServerA,14:44
'@

$ServerDaten | ConvertFrom-CSV | ForEach-Object {
    [PSCustomObject]@{
        Server=$_.Name
        Start=$_.Startzeit
        "Laufzeit(Stunden)"=[Math]::Round(((Get-Date)-[DateTime]$_.Startzeit).TotalHours, 2)
    }
} | Sort-Object "Laufzeit(Stunden)"

# Alternativ per Select-Object
$PropsHash = @(
    @{n="Server";e={$_.Name}},
    @{n="Start";e={$_.Startzeit}},
    @{n="Laufzeit(Stunden)";e={[Math]::Round(((Get-Date)-[DateTime]$_.Startzeit).TotalHours, 2)}}
)

$ServerDaten | ConvertFrom-CSV | Select-Object -Property $PropsHash