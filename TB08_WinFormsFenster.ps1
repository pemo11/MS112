<#
 .Synopsis
 Dialogfenster anzeigen mit Windows Forms
#>

using namespace System.Windows.Forms
using namespace System.Drawing

Add-Type -AssemblyName System.Windows.Forms

function New-Window
{
    [Cmdletbinding()]
    param([Int]$Width, [Int]$Height, [String]$Titel)
    $f = [Form]::new()
    $f.Width = $Width
    $f.Height = $Height
    $f.Font = [Font]::new("Arial", 12)
    $f.Text = $Titel
    $f
}

# $f = New-Window 1000 800 "Dienste-Anzeige"

$f = [Form]::new()
$f.Width = 1000
$f.Height = 800
$f.Font = [Font]::new("Arial", 12)
$f.Text = "Dienste-Anzeige"

$lb1 = New-Object -TypeName Label -Property @{Width=400;Height=40;Left=20;Top=50}
$lb1.Text = "Computername"

$tb = New-Object -TypeName Textbox -Property @{Width=400;Height=120;Left=20;Top=80}

$bnOK = New-Object -TypeName Button -Property @{Width=320;Height=60;Left=20;Top=160}
$bnOK.Text = "Dienste anzeigen"

$bnOK.add_click(
    {
        $Dienste = Get-Service
        foreach($Dienst in $Dienste)
        {
            $lbDienste.Items.Add($Dienst.Name + "->" + $Dienst.Status)
        }
    }

)

$lbDienste = New-Object -TypeName Listbox -Property @{Width=800;Height=400;Left=20;Top=240}

$f.Controls.AddRange(@($lb1, $tb, $bnOK, $lbDienste))
# $f.controls.Add($tb)
#$f.controls.Add($bnOK)
# $f.controls.Add($lbDienste)

$f.ShowDialog()


