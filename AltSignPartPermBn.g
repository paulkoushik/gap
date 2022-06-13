AltSignPartPermBn:= function(sigma)
local n, r, l;
    n:= (LargestMovedPoint(sigma) + SmallestMovedPoint(sigma)-1)/2;
    r:= rec(("true"):= -1, ("false"):= 1);
    l:= List([1..n], i -> r.(String(i^sigma > n)));
return l;
end;
