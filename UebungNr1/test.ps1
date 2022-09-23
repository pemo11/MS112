<#
 .Synopsis
 Pipeline-Function
#>

function Invoke-Test
{
  param([Parameter(ValueFromPipeline=$true)][Object[]]$InputObject)
  process
  {
    "Durchlauf für Prozess mit der Id $($InputObject.Id)"
     $i++
  }
  begin 
  {
   "Begin..."
  }
  end
  {
    "Es waren $i Prozesse"
  }

}