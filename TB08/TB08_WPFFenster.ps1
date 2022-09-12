<#
 .Synopsis
 Ein WPF-Fenster
#>

using namespace System.Windows.Markup
using namespace System.Windows.Forms

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Windows.Forms

$XAML = @'
    <Window
        x:Name="MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title = "WPF-Test"
        Width="600"
        Height="500"
    >
    <StackPanel>
      <TextBox
        x:Name="ComputerNameTextBox"
        Text= "Localhost"
        Width="320"
        Height="32"
        Margin="12"
     />
      <Button
        x:Name="StartButton"
        Content="Bitte klicken!"
        Width="160"
        Height="32"
        Margin="12"
       />
      <ListBox
        x:Name="DiensteLisBox"
        Background="LightGreen"
        Height="320"
        Width="320"
        Margin="6"
      />
    </StackPanel>
   </Window>
'@

$ButtonClickSB = {
    [MessageBox]::Show("Vielen Dank!")
    $ComputerName = $TextBox.Text
    $Dienste = Invoke-Command { Get-Service} # -ComputerName $ComputerName
    $ListBox.ItemsSource = $Dienste
}

$MainWin= [XamlReader]::Parse($Xaml)
$Button = $MainWin.FindName("StartButton")
$TextBox = $MainWin.FindName("ComputerNameTextBox")
$ListBox = $MainWin.FindName("DiensteLisBox")
$Button.add_Click($ButtonClickSB)
# Blockierende Anzeige des Dialogfensters
$MainWin.ShowDialog()
