
$ADUser = Import-CSV -Path .\Material\ADUserDaten.csv -Delimiter ";" -Encoding Default 

# Abfrage des Typs
$ADUser.GetType().Name

# Eindimensionales Array mit Objekten
$ADUser[0].City

$Vornamen  = @("Anton", "Bert","Chris","Dieter","Erik","Franz")

# ForEach ist eine Methode, die es seit Version 4.0 bei jedem Array gibt
$ADUser.ForEach{
    $Vorname = $Vornamen | Get-Random
    $_ | Add-Member -Name "Vorname2" -Value $Vorname -MemberType NoteProperty
}

$ADUser | Format-Table

$ADUser.Where{$_.Vorname2 -eq "Erik"}

$ADUser | Where-Object Vorname -eq "Erik"

# $Vornamen = $Vornamen.ForEach{$_.ToUpper()}


$Vornamen.ForEach{$_ = $_.ToLower()}
$Vornamen

$Zahlen = @(10,20,30,40)
$Zahlen
$Zahlen.ForEach{$_ *= 2}
$Zahlen

$ADUser[0].Vorname