@{
 ModuleVersion="1.0"
 Author="Pemo"
 Description="Ein Beispielmodul für Kurs MS112"
 # Dieser Eintrag legt Module fest, die ebenfalls geladen werden sollen
 NestedModules=@("PsKurs.psm1")
 ScriptsToProcess=@("PsKursExtras.ps1")
}