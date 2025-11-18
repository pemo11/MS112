<#
  .SYNOPSIS
  Beispiel für ForEach mit -Parallel
  .DESCRIPTION
  Erstes Kennenlernen der Funktionsweise
#>

#requires -Version 7

# Alle Wiederholungen auf dem selben Thread
1..10 | ForEach-Object {
  $ThreadId = [appdomain]::GetCurrentThreadId()
  "Durchlauf Nr. $_ (ThreadId: $ThreadId)"
}

# Jeder Durchlauf wird auf einem eigenen Thread ausgeführt
1..10 | ForEach-Object -Parallel {
  $ThreadId = [AppDomain]::GetCurrentThreadId()
  "Durchlauf Nr. $_ (ThreadId: $ThreadId)"
  Start-Sleep -Seconds 2
}