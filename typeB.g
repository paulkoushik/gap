CoxeterB:= function(n)
return Centralizer(SymmetricGroup(2*n), PermList(List([1..2*n], i -> 2*n - i + 1)));
end;

OnTuplesTuplesTuples:= function(x, a)
return List(x, y -> OnTuplesTuples(y,a));
end;

