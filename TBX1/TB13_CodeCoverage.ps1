<#
 .SYNOPSIS
 Tests mit Abdeckung und XML-Ausgabe
#>

$config = New-PesterConfiguration

# Set the test path to specify where your tests are located. In this example, we set the path to the current directory. Pester will look into all subdirectories.
$config.Run.Path = "./TB13_CodeCoverage.tests.ps1"

# Enable Code Coverage
$config.CodeCoverage.Enabled = $true
 # Set a target coverage percentage if desired
$config.CodeCoverage.CoveragePercentTarget = 80 
$config.CodeCoverage.OutputFormat = "Cobertura"
# Run Pester tests using the configuration you've created
Invoke-Pester -Configuration $config