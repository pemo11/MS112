<#
 .Synopsis
 Auflisten der Konstruktoren eines Typs
#>

$i = 0
[PSCredential].GetConstructors().ForEach{
    $i++
    "Konstruktor $i`:"
    $_.GetParameters().ForEach{
        "Name: $($_.Name) - Typ: $($_.ParameterType)"
    }
}
