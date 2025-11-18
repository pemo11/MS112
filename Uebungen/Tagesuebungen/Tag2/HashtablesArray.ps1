<#
 .SYNOPSIS
 Hashtable mit Arrays kombinieren
#>

$ServerConfig = @{
    Server1 = @('App1', 'App2', 'App3')
    Server2 = @('App4', 'App5')
}

# $ServerConfig.Server1[1]  # Gibt 'App2' zurück

$ServerConfig.Server1.Where{ $_ -like 'App*' }  # Filtert Anwendungen, die mit 'App' beginnen   