<#
 .SYNOPSIS
 Diverse Functions
#>

<#
 .SYNOPSIS
 Anlegen einer Csv-Datei mit AD-Userkonten
#>
function New-ADUserCSV
{
    param([Parameter(Mandatory=$true)][String]$Path,
          [Long]$Count=1000)
    $UserListe = @()
    (1..$Count).ForEach{
        $PValue = $_ / $Count * 100
        Write-Progress -Activity "Creating ADUser-Account" -Status "Creation Account Nr. $_" `
         -PercentComplete $PValue
        $UserListe += [PSCustomObject]@{
            Id = $_
            Firstname = "Vorname"
            Surname = "Nachname"
            EMail = "Vorname_Nachname@codeclass.de"
            City = "City"
            OfficePhone = "12345678"
        }
    }
    $UserListe | Export-CSV -Path $Path -Delimiter ";" -Encoding Default -NoTypeInformation
}


<#
 .SYNOPSIS
 CSV-Konvertierung ohne Anführungszeichen für Windows PowerShell
 .Notes
 https://community.idera.com/database-tools/powershell/powertips/b/tips/posts/exporting-csv-without-quotes-and-other-conversion-tricks
#>
function ConvertTo-CSV
{
    param([Char]$Delimiter=",")
    begin
    {
        $init = $false
    }
    process
    {
        # write the headers
        if ($init -eq $false)
        {
            $_.PSObject.Properties.Name -join $Delimiter
            $init = $true
        }
        # write the items
        $_.PSObject.Properties.Value -join $Delimiter
    }
}
