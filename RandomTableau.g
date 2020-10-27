RandomTableau:= function(lambda)
local n, t, a, tt;
    n:= Sum(lambda);
    t:= CanonicalTableau(lambda);
    a:= Random(SymmetricGroup(n));
    tt:= OnTuplesTuples(t,a);
return tt;
end;