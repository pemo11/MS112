# Messagebox anzeigen

using namespace System.Windows.Forms

# Name statt Pfad, da sich die Assemblydatei im GAC befindet
Add-Type -AssemblyName System.Windows.Forms 

$Result = [MessageBox]::Show("Guten Morgen!", "Hinweis", "YesNo", "Exclamation")

if ($Result -eq "Yes")
{
    "yes"
}


