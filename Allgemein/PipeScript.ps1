

param([Parameter(ValueFromPipeline=$True)][Object]$InputObject)
process
{
    # $InputObject * 2
    $_ * 2
        
}
begin { "Start... $input"}
end {"Ende... $input"}

