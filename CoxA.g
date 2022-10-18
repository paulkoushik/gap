# To work with StandardCoefficient2, one needs to read 
# all the previous files in the gap session mentioned below before reading the StandardCoefficient2.g file

#ExpandedList.g

ExpandedList:= function(P)
local i, p, W;
W:= [];
for p in [1..Length(P)] do
for i in [1..P[p]] do
Add(W, p);
od;
od;
return W;
end;

#WordsTableau.g

WordsTableau:= function(tableau)
local rows, cols, i, k, a;
    rows:= [];
    cols:= [];
        for i in [1..Length(tableau)] do
            for k in [1..Length(tableau[i])] do
                a:= tableau[i][k];
                rows[a]:= i;
                cols[a]:= k;
            od;
        od;
return rec(rows:= rows, cols:= cols);
end;

#SYT.g

SYT:= function(lambda)
    local   isOneHook,  removeOneHook,  addOneHook,  n,  list,  i,
            new,  t;

    isOneHook:= function(lambda, i)
        return i = Length(lambda) or lambda[i] > lambda[i+1];
    end;

    removeOneHook:= function(lambda, i)
        local new;
        if i = Length(lambda) and lambda[i] = 1 then
            return lambda{[1..i-1]};
        fi;
        new:= ShallowCopy(lambda);
        new[i]:= new[i]-1;
        return new;
    end;

    addOneHook:= function(t, i, n)
        if i > Length(t) then
            Add(t, [n]);
        else
            Add(t[i], n);
        fi;
        return t;
    end;

    # trivial case first
    if lambda = [1] then
        return [[[1]]];
    fi;

    # initialize
    n:= Sum(lambda);
    list:= [];

    # loop
    for i in Reversed([1..Length(lambda)]) do
        if isOneHook(lambda, i) then
            new:= removeOneHook(lambda, i);
            for t in SYT(new) do
                addOneHook(t, i, n);
                Add(list, t);
            od;
        fi;
    od;

    return list;
end;

#YoungCharacter.g

YoungCharacter:= function(u, v)
    local c, d, pi;
        c:= TransposedMat([u,v]);
            if Size(Set(c)) < Length(c) then
                return 0;
            fi;
        d:= ShallowCopy(c);
        pi:= Sortex(d);
    return SignPerm(pi);
end;

#SpechtMatrix.g

SpechtMatrix:= function(A1, A2)
    local u, v, matrix, row;
    matrix:= [];
        for u in A1 do
            row:= [];
                for v in A2 do
                    Add(row, YoungCharacter(u,v));
                od;
            Add(matrix, row);
        od;
return matrix;
end;

#StandardCoefficient2.g

#Define the partition as lambda
#Define the permutation that you want to apply as sigma

StandardCoefficient:= function(lambda, sigma)
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

#StdCo:= function(t, sm, A, k)

#StdCo:= function(t, specht)
#    local   x,  i,  sm;
#
#    x:= WordsTableau(t).rows;
#    i:= Position(specht.A, x);
#    sm:= specht.sm;
#    return SolutionMat(sm{specht.k}, sm[i]);
#end;


#sigma is a permutation in S_n. 

#atrix:= function(specht, sigma)
#local   pi, rows, stdrows, stdrowspermuted,  m;
#
#pi:= Permutation(sigma, specht.A, Permuted);
#rows:= specht.k;
#stdrows:= TransposedMat(specht.sm){rows};
#stdrowspermuted:= List(stdrows, l -> Permuted(l, pi));
#m:= List(stdrowspermuted, l -> SolutionMat(stdrows, l)); 
#
#return m;
#

RepMatrix:= function(specht, sigma)
    local   pi, stdcolspermuted,  m;

    pi:= Permutation(sigma, specht.A, Permuted);
    stdcolspermuted:= List(TransposedMat(specht.sm), c -> Permuted(c, pi));
    m:= List(stdcolspermuted, c -> SolutionMat(TransposedMat(specht.sm), c)); 
    return m;
end;

SpechtCharacter:= function(lambda, perms)
    local   specht;
    specht:= SpechtObject(lambda);
    return List(perms, sigma -> Trace(RepMatrix(specht, sigma)));
end;

