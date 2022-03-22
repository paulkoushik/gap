TypeB_nGen:= function(n)
local i, gen;
    gen:= [];
        for i in [0..n-2] do
            Add(gen, (i+1,i+2)(2*n-i,2*n-i-1));
        od;
    Add(gen, (1, 2*n), 1);
    return gen;
end;



CoxeterB:= function(n)
    #return Centralizer(SymmetricGroup(2*n), PermList(Reversed([1..2*n])));
    return Group(TypeB_nGen(n));
end;




OnTuplesTuplesTuples:= function(x, a)
return List(x, y -> OnTuplesTuples(y,a));
end;

