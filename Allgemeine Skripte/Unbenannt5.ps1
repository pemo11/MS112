<#
 .Synopsis
 Verschiedene Functions
#>


function f1
{
    <#
     .Synopsis
    Die Rolle der Parametersets
    .Example
    f1 -Path Test.txt
    .Example
    f1 -Path Test.html -HtmlOutput 
    .Example
    f1 -Path Test.html -HtmlOutput -CssFile styles.css
    #>
  [CmdletBinding(DefaultParameterSetname="IrgendetwasAnderes")]
  param([String]$Path, 
        [Parameter(ParameterSetname="Html")][Switch]$HtmlOutput,
        [Parameter(ParameterSetname="Html")][String]$CssFile,
        [Parameter(ParameterSetname="Xml")][Switch]$XmllOutput,
        [Parameter(ParameterSetname="Xml")][String]$SchemaFile
        )
  "Path=$Path HtmlOutput=$HtmlOutput CssFile=$CssFile"
}

# Es ist nicht optimal, wenn immer alle Parameter angeboten werden
# Fast alle Cmdlets besitzen daher Parametersets


Get-Command f1 -Syntax