dir -Path C:\Windows\*.ini | ForEach-Object -Process {
 "*** Aktuelle Datei: $_"
} -Begin {"*** Start der Pipeline-Verarbeitung"} -End {"*** Ende der Pipeline-Verarbeitung"}

# Das Backtick-Zeichen ` ist das Escape-Zeichen
dir -Path C:\Windows\*.ini | ForEach-Object `
{
 "*** Aktuelle Datei: $_"
} 


dir -Path C:\Windows\*.ini | ForEach-Object {
 "*** Aktuelle Datei: $_"
} 