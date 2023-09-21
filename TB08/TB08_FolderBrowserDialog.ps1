<#
 .Synopsis
 Anzeige einer Ordnerauswahl
#>

using namespace System.Windows.Forms

Add-Type -AssemblyName System.Windows.Forms

function Get-Ordnerpfad
{
    [CmdletBinding()]
    param([Parameter(Mandatory=$true)][String]$Ordnerpfad, [String]$Description="Ordnerauswahl")
    $dlg = [FolderBrowserDialog]::new()
    $dlg.Description = $Description
    # $dlg.RootFolder = [System.Environment+Specialfolder]::MyDocuments
    $dlg.SelectedPath = $Ordnerpfad
    $dlg.ShowNewFolderButton = $false
    [void]$dlg.ShowDialog()
    $dlg.SelectedPath
}

$Pfad = Get-Ordnerpfad -Ordnerpfad $env:USERPROFILE\Documents
$Pfad


<#
$dlg = [FolderBrowserDialog]::new()
$dlg.Description = "Beschreibung"
$dlg.RootFolder = [System.Environment+Specialfolder]::Desktop
$dlg.ShowNewFolderButton = $true
$dlg.ShowDialog()

$dlg.SelectedPath
#>

# Optional
# $dlg.Dispose()

