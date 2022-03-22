CanonicalBiTableau:= function(lambda1, lambda2)
local t, t1, o, l;
t:= [];
t1:= [];
Add(t, CanonicalTableau(lambda1));
o:= Sum(lambda1);
    for l in lambda2 do
        Add(t1, o + [1..l]);
        o:= o + l;
    od;
    Add(t, t1);
return t;
end;




