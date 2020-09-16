<#
 .Synopsis
 Anzeige einer Messagebox mit Ja/Nein
#>

using namespace System.Windows.Forms

$Result = [Messagebox]::Show("Weitermachen?", "Bitte bestätigen", "YesNo", "Question")

if($Result -ne "Yes")
{
    "Abbruch..."
    exit
}
"Es geht weiter"

