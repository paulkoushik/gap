
ExpandedListAn:= function(P)
local i, p, W;
W:= [];
for p in [1..Length(P)] do
    for i in [1..P[p]] do
        Add(W, p);
    od;
od;
return W;
end;




ExpandedListBn:= function(lambda)
local i, j, l, w1, w2;
w1:= [];
w2:= [];
l:= List(lambda, ExpandedListAn);
for i in l[1] do
    Add(w1, [i,0]);
od;
for j in l[2] do
    Add(w2, [j,1]);
od;

return Concatenation(w1,w2);
end;





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




CanonicalTableau:= function(lambda)
local t, o, l;
    t:= [];
    o:= 0;
        for l in lambda do
            Add(t, o + [1..l]);
            o:= o + l;
        od;
    return t;
end;


CanonicalBiTableau:= function(lambda)
local t, t1, o, l;
t:= [];
t1:= [];
Add(t, CanonicalTableau(lambda[1]));
o:= Sum(lambda[1]);
    for l in lambda[2] do
        Add(t1, o + [1..l]);
        o:= o + l;
    od;
    Add(t, t1);
return t;
end;






WordsBiTableauBn:= function(tab)
    local rows, cols, i, k, a, b, tab1, tab2;

        rows:= [];
        cols:= [];

        #tableau 1

        tab1:= tab[1];
            for i in [1..Length(tab1)] do
                for k in [1..Length(tab1[i])] do
                    a:= tab1[i][k];
                        rows[a]:= [i,0];
                        cols[a]:= [k,0];                    
                od;
            od;

        #tableau 2

        tab2:= tab[2];
            for i in [1..Length(tab2)] do
                for k in [1..Length(tab2[i])] do
                    b:= tab2[i][k];
                        rows[b]:= [i,1];
                        cols[b]:= [k,1];
                od;
            od;

    return [rows, cols];
end;










YoungCharNew:= function(u, v)
local c, d, pi, i;
    c:= TransposedMat([u,v]);
    if Size(Set(c)) < Length(c) then
        return 0;
    fi;
    for i in c do
        if i[1][2] <> i[2][2] then
            return 0;
        fi;
    od;
    
    d:= ShallowCopy(c);
    pi:= Sortex(d);
    
    return SignPerm(pi);
end;



PermPartBn:= function(u1)
local n, list, l, pi, l1, l2, ll, pi0, p, p0, int;
        if u1 <> () then
            n:= (LargestMovedPoint(u1) + SmallestMovedPoint(u1)-1)/2;
            list:= (ListPerm(u1, 2*n) + n) mod (2*n + 1) - n;
            l:= List(list, AbsInt);
            l1:= l{[n+1..2*n]};
            l2:= -l1 mod (2*n+1);
            l{[n+1..2*n]}:= l2;
            ll:= l;
            pi:= PermList(ll);
            pi0:= u1/pi;
            p:= MovedPoints(pi0);
            p0:= p{[1..Length(p)/2]};
            
            int:= [1..n];
            int{p0}:= -p0;
            
            return int;

        else
            return u1;
        fi;
    end;





SpechtMatNew:= function(A1, A2)
    local u, v, matrix, row;
    matrix:= [];
        for u in A1 do
            row:= [];
                for v in A2 do
                    Add(row, YoungCharNew(u,v));
                od;
            Add(matrix, row);
        od;
return matrix;
end;







#tuple = [lambda1, lambda2]
SYTBn:= function(tuple)
    local   isOneHook,  removeOneHook,  addOneHook,  n,  list,  i, k, lambda,
            new,  t;
    #here lambda is an ordinary partition
    isOneHook:= function(lambda, i)
        return i = Length(lambda) or lambda[i] > lambda[i+1];
    end;


    removeOneHook:= function(tuple, k, i)
        local lambda, new;
        lambda:= ShallowCopy(tuple[k]);
        new:= ShallowCopy(tuple);
        if i = Length(lambda) and lambda[i] = 1 then
            new[k]:= lambda{[1..i-1]};
        else
            lambda[i]:= lambda[i]-1;
            new[k]:= lambda;
        fi;
        return new;
    end;

    addOneHook:= function(t, k, i, n)
        if i > Length(t[k]) then
            Add(t[k], [n]);
        else
            Add(t[k][i], n);
        fi;
        return t;
    end;

    # trivial case first
    if tuple = [[],[]] then
        return [[[[]],[[]]]];
    fi;

    # initialize
    n:= Sum(tuple, Sum);
    list:= [];

    # loop
    for k in Reversed([1..Length(tuple)]) do 
        lambda:= tuple[k];
        for i in Reversed([1..Length(lambda)]) do
            if isOneHook(lambda, i) then
                new:= removeOneHook(tuple, k, i);
                for t in SYTBn(new) do
                    addOneHook(t, k, i, n);
                    Add(list, t);
                od;
            fi;
        od;
    od;

    return list;
end;





SpechtB_nObject:= function(lambda)
    local n, w1, w2, A, sigma, B, sm, syt, words, k;

    n:= Sum(lambda[1])+Sum(lambda[2]);
    w1:= ExpandedListBn(lambda);
    A:= Arrangements(w1, n);

    sigma:= List(lambda, AssociatedPartition);
    w2:= ExpandedListBn(sigma);
    B:= Arrangements(w2, n);

    sm:= SpechtMatNew(A, B);
    syt:= SYTBn(lambda);

    words:= List(syt, WordsBiTableauBn);
    k:= List(words, i -> [Position(A, i[1]), Position(B, i[2])]);
    

    return rec(sm:= sm, A:= A, B:= B, k:= k, syt:= syt);
end;



RepMatBn:= function(specht, sigma)
    local pi, smT, l, mat, k, M;

    pi:= Permutation(sigma, specht.A, Permuted);
    smT:= TransposedMat(specht.sm);
    l:= List(specht.k, i -> i[2]);
    mat:= smT{l};

    k:= List(smT, i -> Permuted(i, pi));
    M:= List(k, i -> SolutionMat(mat, i));

    return M;
end;








#ClassRep.g


pcycle:= function(o,l)
return o+[2..l]; 
end;


ncycle:= function(o,l)
return Concatenation([o+1,o..1],[2..o+l]);
end;


ClassRep:= function(lambda)
    local w, o, l;
    
    w:=[];
    o:= 0;   
    for l in Reversed(lambda[2]) do
        Append(w, ncycle(o,l));
        o:= l+o;
    od;
    
    for l in lambda[1] do          
        Append(w, pcycle(o,l));
        o:= l+o;
    od;
    return w;
end;







SpechtBnCharacter:= function(lambda, gens)
    local n, Bipartitions, specht, classes, list;
    n:= Sum(lambda[1])+Sum(lambda[2]);
    Bipartitions:= PartitionTuples(n,2);
    specht:= SpechtB_nObject(lambda);
    classes:= List(Bipartitions, ClassRep);
    classes[1]:= [1,1];
    list:= List(gens, sigma -> RepMatBn(specht, sigma));
    return List(classes, c -> TraceMat(Product(list{c})));
end;









