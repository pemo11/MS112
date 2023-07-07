<#
 .SYNOPSIS
 enum-Konstanten beim switch-Befehl
#>
enum DataProvider
{
    SQLServer
    Oracle
    SQLite
}

$dbProvider = [DataProvider]::SQLServer

switch ($dbProvider)
{
    SQLServer { "Hier ist der SQL-Server" }
    Oracle { "Hier ist der Oracle-Server"}
    SQLite { "Und hier ist SQLite"}
    default { "Default-Aktion"}
}
