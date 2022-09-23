<#
.Synopsis
 Select-Xml-Beispiel
#>

$TypesDateipfad = "C:\Windows\System32\WindowsPowerShell\v1.0\types.ps1xml"

$XPfad = "//Type[Name='System.Diagnostics.Process']/Members"
Select-Xml -Path $TypesDateipfad -XPath $XPfad | Select-Object -ExpandProperty Node | ForEach-Object {

    "`nAlias-Properties:" 
    $_ | Select-Object -ExpandProperty AliasProperty
    "`nScript-Properties:" 
    $_ | Select-Object -ExpandProperty ScriptProperty
    "`nNote-Properties:" 
    $_ | Select-Object -ExpandProperty NoteProperty
}
