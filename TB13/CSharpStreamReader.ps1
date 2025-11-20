<#
 .SYNOPSIS
 Einlesen einer sehr großen Datei per C# Exe
#>

$CSCode = @'
using System;
using System.IO;

public class LargeFileReader
{
    public static string ReadFile(string filePath)
    {
        using (var reader = new StreamReader(filePath))
        {
            string totalContent = "";
            try 
            {
                totalContent = reader.ReadToEnd();
            }
            catch (OutOfMemoryException)
            {
                Console.WriteLine("Datei zu groß, um sie vollständig im Speicher zu halten.");
            }
            return totalContent;
        }
    }
}
'@

# Aus dem C# Code eine DLL erstellen
Add-Type -TypeDefinition $CSCode -Language CSharp -OutputAssembly "LargeFileReader.dll"

