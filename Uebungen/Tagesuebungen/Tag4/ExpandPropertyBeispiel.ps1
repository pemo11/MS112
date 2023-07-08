# Die Rolle des ExpandProperty-Parameters bei Select-Object

Get-Process -Id $PID | Select-Object -Property StartInfo
Get-Process -Id $PID | Select-Object -ExpandProperty StartInfo

Get-Process -Id $PID | Select-Object -ExpandProperty StartInfo | Select-Object Environment

Get-Process -Id $PID | Select-Object -ExpandProperty StartInfo |
  Select-Object -ExpandProperty Environment

Get-Process -Id $PID | Select-Object -ExpandProperty StartInfo |
  Select-Object -ExpandProperty EnvironmentVariables

# Wenn es nur um den Wert geht (und nicht um ein Objekt mit einer Eigenschaft)
Get-Process -Id $PID | Select-Object -ExpandProperty StartTime

Get-ACL -Path . | Select-Object -ExpandProperty Access