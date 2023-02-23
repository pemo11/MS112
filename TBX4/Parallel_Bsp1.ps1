<#
  .SYNOPSIS
  Beispiel f�r ForEach mit -Parallel
  .DESCRIPTION
  Erstes Kennenlernen der Funktionsweise
#>

#requires -Version 7

# Alle Wiederholungen auf dem selben Thread
1..10 | ForEach-Object {
  $ThreadId = [appdomain]::GetCurrentThreadId()
  "Durchlauf Nr. $_ (ThreadId: $ThreadId)"
}

# Jeder Durchlauf wird auf einem eigenen Thread ausgef�hrt
1..10 | ForEach-Object -Parallel {
  $ThreadId = [AppDomain]::GetCurrentThreadId()
  "Durchlauf Nr. $_ (ThreadId: $ThreadId)"
}