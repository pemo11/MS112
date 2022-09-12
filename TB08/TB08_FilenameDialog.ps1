<#
 .Synopsis
 Anzeige einer Dateinamenauswahl
#>

using namespace System.Windows.Forms

Add-Type -AssemblyName System.Windows.Forms

# $FileBrowser = New-Object -TypeName OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath("Desktop") }
# $FileBrowser = New-Object -TypeName OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath("MyDocuments") }
$FileBrowser = New-Object -TypeName OpenFileDialog -Property @{ InitialDirectory = "E:\2020" }

[void]$FileBrowser.ShowDialog()

$FileBrowser