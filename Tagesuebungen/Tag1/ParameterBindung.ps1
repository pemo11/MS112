
(Get-Process | Where-Object WorkingSet64 -gt 100MB).Count

dir | Get-Member *time*


dir | Select-Object Name,LastAccessTime| Sort-Object LastAccessTime -Descending


# Festlegen einer inviduellen Sortierreihenfolge dank eines ScriptBlocks
dir | Select-Object Name,LastAccessTime| Sort-Object { $_.LastAccessTime.Hour } -Descending


Trace-Command -Name ParameterBinding -Expression { "Test.dat" | Remove-Item } -PSHost

Trace-Command -Name ParameterBinding -Expression { "iexplore" | stop-process} -PSHost

# Ich baue mir ein Objekt mit einer name-Eigenschaft mit Hilfe von select-Object und einer Hashtable
"iexplore" | select-object @{n="Name";e={$_}} | stop-process
"iexplore" | select @{n="Name";e={$_}} | kill