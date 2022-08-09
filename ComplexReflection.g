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




ExpandedListCRG:= function(lambda)
local i, j, l, k, w1, w2, w3;
w1:= [];
w2:= [];
w3:= [];
l:= List(lambda, ExpandedListAn);
for i in l[1] do
    Add(w1, [i,0]);
od;
for j in l[2] do
    Add(w2, [j,1]);
od;
for k in l[3] do
    Add(w3, [k,2]);
od;

return Concatenation(w1,w2,w3);
end;



#######################################################


CRTGen:= function(r,n)
local gen, l, i;
gen:= [];
l:= ListWithIdenticalEntries(n,1);
l[1]:= E(r);
Add(gen, DiagonalMat(l));
for i in [1..(n-1)] do
    Add(gen, PermutationMat((i, i+1), n, 1));
od;
return gen;
end;


#######################################################


#ComplexReflectionGroup:= function(r,n)
#local gens, G, sb, v, a, w, W;
#gens:= CRTGen(r,n);
#G:= Group(gens);
#sb:= IdentityMat(n);
#for v in sb do
#    for a in gens do
#        w:= v*a;
#        if not w in sb then
#            Add(sb, w);
#        fi;
#    od;
#od;
#W:= Action(G, sb, OnRight);
#return W;
#end;


ComplexReflectionGroup:= function(r,n)
local gen;
gen:= CRTGen(r,n);
return Group(gen);
end;


#######################################################

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



CanonicalCRGTableau:= function(lambda)
local t, t1, t2, o, p, l;
t:= [];
t1:= [];
t2:= [];
Add(t, CanonicalTableau(lambda[1]));
o:= Sum(lambda[1]);
    for l in lambda[2] do
        Add(t1, o + [1..l]);
        o:= o + l;
    od;
    Add(t, t1);
p:= Sum(lambda[1])+Sum(lambda[2]);
    for l in lambda[3] do
        Add(t2, p + [1..l]);
        p:= p + l;
    od;
    Add(t, t2);
return t;
end;

#CanonicalCRGTableau:= function(lambda)
#local t, t1, o, l;
#t:= [];
#t1:= [];
#Add(t, CanonicalBiTableau(lambda));
#o:= Sum(lambda[1])+Sum(lambda[2]);
#    for l in lambda[3] do
#        Add(t1, o + [1..l]);
#        o:= o + l;
#    od;
#    Append(t, [[t1]]);
#return t;
#end;



#######################################################



WordsCRGTableau:= function(tab)
    local rows, cols, i, k, a, b, c, tab1, tab2, tab3;

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

        #tableau 3

        tab3:= tab[3];
            for i in [1..Length(tab3)] do
                for k in [1..Length(tab3[i])] do
                    c:= tab3[i][k];
                        rows[c]:= [i,2];
                        cols[c]:= [k,2];
                od;
            od;

    return [rows, cols];
end;



#######################################################



YoungCharCRG:= function(u, v)
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


#######################################################


SpechtMatCRG:= function(A1, A2)
    local u, v, matrix, row;
    matrix:= [];
        for u in A1 do
            row:= [];
                for v in A2 do
                    Add(row, YoungCharCRG(u,v));
                od;
            Add(matrix, row);
        od;
return matrix;
end;


#######################################################


#tuple = [lambda1, lambda2]
SYT_CRG:= function(tuple)
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
    if ForAll(tuple, x -> x = []) then
        return [List(tuple, x -> [[]])];
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
                for t in SYT_CRG(new) do
                    addOneHook(t, k, i, n);
                    Add(list, t);
                od;
            fi;
        od;
    od;

    return list;
end;


#######################################################


SpechtCRGObject:= function(lambda)
    local n, w1, w2, A, sigma, B, sm, syt, words, k;

    n:= Sum(lambda, Sum);
    w1:= ExpandedListCRG(lambda);
    A:= Arrangements(w1, n);

    sigma:= List(lambda, AssociatedPartition);
    w2:= ExpandedListCRG(sigma);
    B:= Arrangements(w2, n);

    sm:= SpechtMatCRG(A, B);
    syt:= SYT_CRG(lambda);

    words:= List(syt, WordsCRGTableau);
    k:= List(words, i -> [Position(A, i[1]), Position(B, i[2])]);
    

   return rec(sm:= sm, A:= A, B:= B, k:= k, syt:= syt);
end;


#######################################################

#Let G be the complex reflection group considered as a matrix group.
#Let g is an element (a matrix) of G.

RepMatCRG:= function(specht, g)
    local n, sigma, pi, smT, l, mat, k, M;
    
    n:= Length(g);
    sigma:= PermList(List(g, x -> PositionProperty(x, i -> i <> 0)));
    pi:= Permutation(sigma, specht.A, Permuted);
    smT:= TransposedMat(specht.sm);
    l:= List(specht.k, i -> i[2]);
    mat:= smT{l};

    k:= List(mat, i -> Permuted(i, pi));
    M:= List(k, i -> SolutionMat(mat, i));

    return M;
end;


SignMatCRG:= function(specht, g)
local n, so, l, sign, index, ind, M;

    n:= Length(g);
    l:= List(specht.k, i -> i[1]);
    sign:= List(g, x -> First(x, i -> i <> 0));
#index:= List(specht.A{l}, i -> i[1][2]);
    ind:= List(specht.A{l}, i -> Product([1..n], j -> sign[j]^i[j][2]));
    M:= DiagonalMat(ind);

return M;
end;


RepresentativeMatCRG:= function(specht, g)
local M, N;
    M:= SignMatCRG(specht, g);
    N:= RepMatCRG(specht, g);
return M*N;
end;


#######################################################


BlockMatCRG:= function(lambda)
local n, M, o, i, a, mat, r;
n:= Sum(lambda, Sum);
r:= Length(lambda);
M:= NullMat(n,n);
o:= 0;
for i in [1..r] do
    for a in lambda[i] do
            
            mat:= PermutationMat(PermList(([1..a] mod a) + 1), a);
            mat[a][1]:= E(r)^(i-1);

        M{o+[1..a]}{o+[1..a]}:= mat;
        o:= o + a;
    od;
od;
return M;
end;


#######################################################



