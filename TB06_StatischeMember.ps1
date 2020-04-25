<#
 .Synopsis
 Auflisten statischer Member
#>

([System.DateTime].GetMembers() | Where-Object { 
     $_.IsStatic -and $_.Name –notlike "*_*" }).Name |
    Sort-Object -Unique
