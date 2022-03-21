#Step-1: Take a list of numbers [1,2,...,n] where n=k+l, k:= Sum(lambda) and l:= Sum(mu) where lambda and mu are two partitions. Therefore apply S_n on [1,...,n].

#Step-2: Then take the first k elements from the permuted list and arrange them into lambda-tableau.

#Step-3: Then take the last (n-k)-l elements from that same permuted list and arrange them into mu-tableau.












RandomDoubleTableau:= function(lambda, mu)
local l, k, n, list, L, a, new, j, newlist, i;
    

    l:= Sum(lambda);
    k:= Sum(mu);
    n:= l + k;

    list:= [1..n];
    L:= [];
    
    a:= Random(SymmetricGroup(n));
    newlist:= OnTuples(list, a);
    
        for i in lambda do
            Add(L, [new[1]..new[i]]);
        od;








#trial of step-2

        for i in lambda do
            for j in newlist do
                if Position(newlist, j) <= i then
                    Add(L, [newlist[j]..newlist[i]]);
                elif Position(newlist, j) <= (lambda[i] + lambda[i+1]) then
                    Add(L, [newlist[lambda[i] + lambda[i+1]]..newlist[k]]);
                fi;
            od;
        od;
        



    return ;
end;
