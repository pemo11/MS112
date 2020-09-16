

function f1
{
    param([Parameter(Position=1)]$P1, [Parameter(Position=3)]$P2, [Parameter(Position=2)]$P3)
    # "P1=$($Args[0]) P2=$($Args[1]) P3=$($Args[2])"
    "P1=$P1 P2=$P2 P3=$P3"

}


# f1 11 22 33

f1 -P2 22 33  11