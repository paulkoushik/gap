CRTGen:= function(r,n)
local gen, l, i;
gen:= [];
l:= ListWithIdenticalEntries(n,1);
l[1]:= E(r);
Add(gen, DiagonalMat(l));
for i in [1..(n-1)] do
    Add(gen, PermutationMat((i, i+1), n, 1));
od;
return gen;
end;
