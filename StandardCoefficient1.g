#Define the partition as lambda  
#Define the permutation that you want to apply as sigma
## sigma is a global variable, hence it needs to be defined beforehand

StandardCoefficient1:= function(lambda, sigma)
    local syt, rows, cols, a, b, A, B, sm, tt, col, l, k, m; 
        syt:= SYT(lambda);
        rows:= List(syt, x -> WordsTableau(x).rows);
        cols:= List(syt, x -> WordsTableau(x).cols);
        a:= ExpandedList(lambda);
        A:= Arrangements(a, Size(a));
        b:= ExpandedList(AssociatedPartition(lambda));
        B:= Arrangements(b, Size(b));
        sm:= SpechtMatrix(A, B);
        tt:= List(syt, x -> OnTuplesTuples(x, sigma));
        col:= List(tt, x -> WordsTableau(x).cols);
        l:= List(col, x -> Position(B, x));
        k:= List(syt, x -> Position(B, WordsTableau(x).cols));
        m:= List(l, i -> SolutionMat(sm{k}, sm[i]));
    return m;
end;
