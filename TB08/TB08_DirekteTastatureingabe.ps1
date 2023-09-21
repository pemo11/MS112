<#
 .Synopsis
 Beispiel für eine direkte Tastatureingabe
 #>
$StartZeit = Get-Date

while ($true)
{
    if ([Console]::KeyAvailable)
    {
        $k = [Console]::ReadKey($true)
        if ($k.KeyChar -eq "q")
        {
            break;
        }q
    }
    "Abbruch per 'Q'-Taste..."
     Start-Sleep -Seconds 1
}

"Abbruch nach {0:n2}s" -f ((Get-Date)-$Startzeit).TotalSeconds