CanonicalBiTableau:= function(lambda)
local t, t1, o, l;
t:= [];
t1:= [];
Add(t, CanonicalTableau(lambda[1]));
o:= Sum(lambda[1]);
    for l in lambda[2] do
        Add(t1, o + [1..l]);
        o:= o + l;
    od;
    Add(t, t1);
return t;
end;




