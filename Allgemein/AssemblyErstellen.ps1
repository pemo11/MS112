<#
 .Synopsis
 Erstellen einer Assembly mit C#-Code
#>

using namespace posh

# Here-String
$CSCode = @'
 using System;

 namespace posh
 {
    public class Test
    {
       public static string Ausgabe()
       {
           return "Hallo, Welt!";
       }

       public int Add(int p1, int p2)
       {
           return p1 + p2;
       }
    }
 }
'@


#Add-Type -TypeDefinition $CSCode -OutputType Library -OutputAssembly HalloWelt.dll 

Add-Type -Path .\HalloWelt.dll -PassThru  | Select-Object Fullname, Namespace

[Posh.Test]::Ausgabe()

$o = [Posh.Test]::new()
$o.Add(11,22)

$o | Get-Member -Static

$o = New-Object -TypeName Posh.Test
$o.Add(10,20)

$o = New-Object -TypeName Test

[System.AppDomain]::CurrentDomain.GetAssemblies()