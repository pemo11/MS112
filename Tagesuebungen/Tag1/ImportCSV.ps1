
Get-Content -Path Prozesse.txt | Select-Object @{n="Name";e={$_}} | Stop-Process -WhatIf

Get-Content -Path Prozesse.txt | Select-Object @{n="Name";e={($_ -split ",")[0]}},@{n="Aktion";e={($_ -split ",")[1]}} |
 Where-Object Aktion -eq "true" | Stop-Process -WhatIf

Import-CSV .\prozesse.txt -Header "Name","Aktion" | Where-Object Aktion -eq "true" | Stop-Process -WhatIf


Import-CSV .\prozesse2.txt -Delimiter "`t" | Where-Object Beenden -eq "true" | Stop-Process -WhatIf

Import-CSV .\prozesse3.txt -Delimiter "`t" | Where-Object "Prozess Name" -eq "notepad"

Import-CSV .\prozesse3.txt -Delimiter "`t" | Where-Object {Prozess Name} -eq "notepad"

# Die Schreibweise bei PowerShell 2.0 
Import-CSV .\prozesse3.txt -Delimiter "`t" | Where-Object { $_.{Prozess Name} -eq "notepad"}