<#
 .Synopsis
 Ein Beispiel für den Pipeline-Parameter
#>

# Ein sehr einfaches Beispiel für das generelle Verständnis

(1..10) | Where-Object -PipelineVariable z { $_ % 2 -eq 1} | ForEach-Object {
    "$z wurde geprüft"
}

Get-Process -PipelineVariable p | Select-Object StartTime -First 3 | ForEach-Object {
    "Prozess: $($p.Name) startete um $($_.StartTime)"
}

# Verzeichnisse ausgeben, auf die ein Benutzerkonto Vollzugriff besitzt,
# das kein Admin ist
Get-ChildItem -Path C:\ -ErrorAction Ignore -Directory -PipelineVariable File |
  Get-ACL | Select-Object -ExpandProperty Access |
  Where-Object { $_.FileSystemRights -eq "FullControl" -and  `
   $_.IdentityReference -notmatch "Administratoren"} |
   Select-Object -Property IdentityReference,  @{n="Path";e={$File.FullName } }
