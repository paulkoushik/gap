CoxeterB:= function(n)
return Centralizer(SymmetricGroup(2*n), PermList(Reversed([1..2*n])));
end;

OnTuplesTuplesTuples:= function(x, a)
return List(x, y -> OnTuplesTuples(y,a));
end;

