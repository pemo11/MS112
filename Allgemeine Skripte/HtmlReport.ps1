<#
 .SYNOPSIS
 Verschiedene Abfragen in einem HTML-Report zusammenfassen
#>

# Die 5 Prozesse, die den meisten Arbeitsspeicher belegen
$Prozesse = Get-Process | Sort-Object WS -Descending |
 Select-Object  -Property @{n="Name";e={$_.Name.Substring(0,1).ToUpper() +
  $_.Name.Substring(1)}}, StartTime, WS | Sort-Object StartTime -Descending

$ProzessDaten = $Prozesse | ConvertTo-Html -Fragment

$PCInfo = Get-CimInstance -ClassName Win32_ComputerSystem |
 Select-Object TotalPhysicalMemory, Model, Manufacturer | ConvertTo-Html -Fragment

$Head = @"
<style>
Table {
    width:80%;
    border-width: 1px;
    border-style: solid;
    border-color: black;
    border-collapse: collapse;
}
Th {border-width: 1px; padding: 3px; border-style: solid; color: #22c0c2; border-color: #22c0c2; background-color: #00386e;}
Td {border-width: 2px; padding: 3px; border-style: solid; border-color: #22c0c2; white-space:pre-line}
H11 {color: #25e712;}
H12 {color: #006400;}
H13 {color: #ff8c00;}
H14 {color: #8b0000;}
</style>
"@

$Body = "<H3>PC-Report<H3>"
$Body += $PCInfo
$Body += "<div/>"
$Body += $ProzessDaten
$Body += "<div/>"

$PostContent = "Daten erfasst um $(Get-Date -Format t)"

$HtmlPath = Join-Path -Path $PSScriptRoot -ChildPath ("PCReport_{0}.html" -f
 (Get-Date -Format "MM_dd"))
$CssPath = Join-Path -Path $PSScriptRoot -ChildPath "PoshKurs.css"

$HtmlParas = @{
   Body = $Body
   Head = $Head
   Title = "PC-Report"
   # Charset = "Utf-8"
   CssUri = $CssPath
   Postcontent = $PostContent
}

ConvertTo-Html @HtmlParas  | Out-File $HtmlPath -Encoding utf8

.$HtmlPath