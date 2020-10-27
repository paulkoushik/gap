RandomSYT:= function(lambda)
local n, t, a, t1, t2, tt;
    n:= Sum(lambda);
    t:= CanonicalTableau(lambda);
    a:= Random(SymmetricGroup(n));
    tt:= OnTuplesTuples(t, a);
    t1:= List(tt, Set);
    t2:= TransposedMat(List(TransposedMat(t1), Set));
return t2;
end;
