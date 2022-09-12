<#
 .Synopsis
 Auflisten der geladenen Assemblies
#>

# Auflisten der Verzeichnispfade
[AppDomain]::CurrentDomain.GetAssemblies().Location

# Auflisten von Name und Version
[AppDomain]::CurrentDomain.GetAssemblies().ForEach{
    [PSCustomObject]@{
        Name=$_.GetName().Name
        Version=$_.GetName().Version
    }
}