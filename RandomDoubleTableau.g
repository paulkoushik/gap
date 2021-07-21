RandomDoubleTableau:= function(lambda, mu)
local m, n, k, t, a, tt, L, i, LL, b;
    L:= [];

    n:= Sum(lambda);
    m:= Sum(mu);
    k:= n + m;

    
    
    t:= CanonicalTableau(lambda);
    
    a:= Random(SymmetricGroup(n));
    tt:= OnTuplesTuples(t,a);
    
        for i in mu do 
            Add(L, n+ [1..i]);
            n:= n + i;
        od;


    b:= Random(SymmetricGroup(m));
    LL:= OnTuplesTuples(L, b);
    
    return [tt, LL];
end;
