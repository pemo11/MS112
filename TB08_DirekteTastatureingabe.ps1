<#
 .Synopsis
 Beispiel für eine direkte Tastatureingabe
 #>
$StartZeit = Get-Date

while ($true)
{
    if ([Console]::KeyAvailable)
    {
        if ([Console]::ReadKey($true).KeyChar -eq "q")
        {
            break;
        }
    } 
    "Abbruch per 'Q'-Taste..."
     Start-Sleep -Seconds 1
}

"Abbruch nach {0:n}s" -f ((Get-Date)-$Startzeit).TotalSeconds