

$XmlPfad = "E:\Web.config"

[Xml]$XmlDoc = Get-Content -Path $XmlPfad -Encoding UTF8

# $XmlDoc.configuration.connectionStrings | Select-Object -ExpandProperty OuterXml
$muster = "Catalog=(\w+)"
$muster = "Catalog=\w+"
$XmlDoc.configuration.connectionStrings.add.connectionstring | ForEach-Object {
 [Regex]::Match($_, $muster).Value.split("=")[1] # .Groups[1].Value
}

($XmlDoc.configuration.connectionStrings.add | Where-Object ConnectionString -like "*Monitor*").connectionString

$XmlDoc.configuration.connectionStrings.add[0].GetAttribute("connectionString")

$XmlDoc.configuration.connectionStrings.add[0].SetAttribute("connectionString", "Neuer Wert")

$XmlDoc.Save("test123.xml")