<#
  .SYNOPSIS
  Beispiel für ForEach mit -Parallel
  .DESCRIPTION
 Die Rolle des ThrottleLimit-Parameters
 Gute Übersicht über die ANSI-Codes
 https://duffney.io/usingansiescapesequencespowershell/
#>

#requires -Version 7

function Get-CpuCore
{
    (Get-CimInstance -ClassName Win32_Processor).NumberOfCores
}

"Anzahl Cores: $(Get-CpuCore)"

# Jeder Durchlauf wird auf einem eigenen Thread ausgeführt
# Der Default für ThrottleLimit ist 5
$StartTime = Get-Date

$Esc = [char]27

"`e[32m *** Ausführung mit ThrottleLimit=5 ***$Esc[0m"
1..10 | ForEach-Object -ThrottleLimit 5 -Parallel {
    $ThreadId = [AppDomain]::GetCurrentThreadId()
    "Durchlauf Nr. $_ (ThreadId: $ThreadId)"
    Start-Sleep -Seconds 1
}
"`e[5;36m $(((Get-Date)-$StartTime).TotalSeconds)s $Esc[0m"

"`e[33m *** Ausführung mit ThrottleLimit=10 ***$Esc[0m"

$StartTime = Get-Date
1..10 | ForEach-Object -ThrottleLimit 10 -Parallel {
    $ThreadId = [AppDomain]::GetCurrentThreadId()
    "Durchlauf Nr. $_ (ThreadId: $ThreadId)"
    Start-Sleep -Seconds 1
}
"`e[5;36m $(((Get-Date)-$StartTime).TotalSeconds)s $Esc[0m"