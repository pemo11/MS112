<#
 .Synopsis
 Übung 7 - Msgbox-Function
#>

function Msgbox
{

    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show()

}
