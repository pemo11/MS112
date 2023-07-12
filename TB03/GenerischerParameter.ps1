<#
  .SYNOPSIS
  Generische Liste als Parameter einer Function
#>
using namespace System.Collections.Generic

function Convert-FirstUpper
{
    param([List[String]]$Namen)
    $Namen.ToArray().ForEach{ $_.Substring(0,1).ToUpper() + $_.Substring(1).ToLower() }
}

$Namen = [List[String]]::new()
$Namen.Add("hugo")
$Namen.Add("bErnd")
$Namen.Add("SUSI")

Convert-FirstUpper -Namen $Namen