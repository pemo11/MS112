<#
 .SYNOPIS
 Dialogfenster anzeigen
#>
using namespace System.Windows.Forms
using namespace System.Drawing

Add-Type -AssemblyName System.Windows.Forms

$f = [Form]::New()
$f.Text = "Eingabedialogfenster"
$f.Size = [Size]::new(400,200)
$f.StartPosition = "CenterScreen"
$tb1 = [TextBox]::New()
$tb1.Location = [Point]::new(40,10)
$tb1.Size = [Size]::New(120,50)
$tb1.BackColor = "LightYellow"
$tb1.Name = "username"

$btn1 = [Button]::new()
$btn1.Text = "Bitte klicken"
$btn1.Size = [Size]::New(120,40)
$btn1.Location = [Point]::new(40,40)

$btn1.add_Click( {
    [Messagebox]::Show($tb1.text)
})

$f.Controls.Add($tb1)
$f.Controls.Add($btn1)

$f.ShowDialog()