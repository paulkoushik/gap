SignedImageList:= function(sigma)
local n, l;
    n:= (LargestMovedPoint(sigma) + SmallestMovedPoint(sigma) -1)/2;
    l:= ListPerm(sigma);
    return (l{[1..n]}+n) mod (2*n+1) - n;
end;