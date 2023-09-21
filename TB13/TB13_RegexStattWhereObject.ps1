<#
 .Synopsis
 Ausgabeverarbeitung per Regex
#>

$NetstatOutput = netstat -ao

$Muster = "^\s+TCP\s+([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}):(\d+).*\s+(\d+)$"

$NetstatOutput | Out-String -Stream | Select-String -Pattern $Muster |
 Select-Object @{n="IP";e={$_.Matches[0].Groups[1].Value}},
               @{n="LocalPort";e={$_.Matches[0].Groups[2].Value}},
               @{n="PID";e={$_.Matches[0].Groups[3].Value}} | Where-Object IP -ne "0.0.0.0"