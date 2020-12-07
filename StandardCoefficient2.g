#Define the partition as lambda
#Define the permutation that you want to apply as sigma
## sigma is a global variable, hence it needs to be defined beforehand

StandardCoefficient1:= function(lambda, sigma)
    local   syt,  a,  A,  B,  sm,  tt,  col,  l,  k,  m;

    syt:= SYT(lambda);

    a:= ExpandedList(lambda);
    A:= Arrangements(a, Size(a));
    B:= List(syt, x -> WordsTableau(x).cols);

    sm:= SpechtMatrix(A, B);
    tt:= List(syt, x -> OnTuplesTuples(x, sigma));
    col:= List(tt, x -> WordsTableau(x).rows);
    l:= List(col, x -> Position(A, x));
    k:= List(syt, x -> Position(A, WordsTableau(x).rows));
    m:= List(l, i -> SolutionMat(sm{k}, sm[i]));
    return m;
end;

#StdCo:= function(t, sm, A, k)
StdCo:= function(t, specht)
    local   x,  i,  sm;

    x:= WordsTableau(t).rows;
    i:= Position(specht.A, x);
    sm:= specht.sm;
    return SolutionMat(sm{specht.k}, sm[i]);
end;

SpechtObject:= function(lambda)
    local   syt,  a,  A,  k,  B,  sm;

    syt:= SYT(lambda);

    a:= ExpandedList(lambda);
    A:= Arrangements(a, Size(a));
    k:= List(syt, x -> Position(A, WordsTableau(x).rows));
    B:= List(syt, x -> WordsTableau(x).cols);

    sm:= SpechtMatrix(A, B);

    return rec(sm:= sm, A:= A, B:= B, syt:= syt, k:= k);
end;

RepMatrix:= function(specht, sigma)
    local   tt,  m;

    tt:= List(specht.syt, x -> OnTuplesTuples(x, sigma));
    m:= List(tt, t-> StdCo(t, specht));

    return m;
end;

SpechtCharacter:= function(lambda, perms)
    local   specht;
    specht:= SpechtObject(lambda);
    return List(perms, sigma -> Trace(RepMatrix(specht, sigma)));
end;