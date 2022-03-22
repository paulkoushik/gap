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


#typeB.g

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



#ArrangementsBn.g

ArrangementsBn:= function(w)
return Orbit(CoxeterB(Length(w)/2), w, Permuted);
end;


#CanonicalTableau.g

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


#MirroredWord.g

MirroredWord:= function(w)

local w1, w2, i;

w1:= [];
w2:= [];

for i in w do
    Add(w1, i);
        if IsInt(i) then
            Add(w2, -i);
        else
            Add(w2, i);
        fi;
od;

return Concatenation(w1, Reversed(w2));

end;


#WordsBiTableau.g

WordsBiTableau:= function(tab)
    local rows, cols, i, k, a, b, tab1, tab2;

        rows:= [];
        cols:= [];

        #tableau 1

        tab1:= tab[1];
            for i in [1..Length(tab1)] do
                for k in [1..Length(tab1[i])] do
                    a:= tab1[i][k];
                        if a > 0 then
                            rows[a]:= String(i);
                            cols[a]:= k;
                        else
                            rows[-a]:= String(i);
                            cols[-a]:= -k;
                        fi;
                od;
            od; 


        #tableau 2

        tab2:= tab[2];
            for i in [1..Length(tab2)] do
                for k in [1..Length(tab2[i])] do
                    b:= tab2[i][k];
                        if b > 0 then
                            rows[b]:= i;
                            cols[b]:= String(k);
                        else
                            rows[-b]:= -i;
                            cols[-b]:= String(k);
                        fi;
                od;
            od;

    return List([rows, cols], MirroredWord);

end;


#BiPartitionWord.g

BiPartitionWord:= function(w1)
local lambda, a;
lambda:= [[],[]];

for a in w1{[1..Length(w1)/2]} do
    if IsInt(a) then 
        a:= AbsInt(a);

        if IsBound(lambda[2][a]) then
            lambda[2][a]:= lambda[2][a]+1;
        else
            lambda[2][a]:= 1;
        fi;

    else 

        a:= Int(a);

        if IsBound(lambda[1][a]) then
            lambda[1][a]:= lambda[1][a]+1;
        else
            lambda[1][a]:= 1;
        fi;
    fi;
od;

return lambda;
end;


#YoungCharacter_Bn.g

YoungCharacter_Bn:= function(w1, w2)
    local c, p, n, list, l, pi, lambda, t, t1, t2, pi0, u1, w;



        c:= TransposedMat([w1, w2]);

        if Size(Set(c)) < Length(c) then
            return 0;
        fi;
        p:= Set(c, x -> Number(x, IsInt));

        if p <> [1] then 
            return 0;
        fi;
        lambda:= BiPartitionWord(w1);
        t1:= CanonicalTableau(lambda[1]);
        t2:= CanonicalTableau(lambda[2]) + Sum(lambda[1]);

        t:= [t1, t2];
        
        w:= WordsBiTableau(t);
        pi0:= Sortex(ShallowCopy(TransposedMat(w)));
        pi:= Sortex(ShallowCopy(c));
        u1:= pi/pi0;

        if u1 <> () then
            n:= (LargestMovedPoint(u1) + SmallestMovedPoint(u1)-1)/2;
            list:= (ListPerm(u1){[1..n]} + n) mod (2*n + 1) - n;
            l:= List(list, AbsInt);
            pi:= PermList(l); 

            return SignPerm(u1 * pi);

        else
            return 1;
        fi;
end;


#SpechtMatrix_Bn.g

SpechtMatrix_Bn:= function(A1, A2)
    local u, v, matrix, row;
    matrix:= [];
        for u in A1 do
            row:= [];
                for v in A2 do
                    Add(row, YoungCharacter_Bn(u,v));
                od;
            Add(matrix, row);
        od;
return matrix;
end;





SpechtObject:= function(lambda1, lambda2)
    local   lambda, w1, w2, w, A, sigma1, sigma2, sigma, u1, u2, u, B, sm, ;

    lambda:= [lambda1, lambda2];
    w1:= List(ExpandedList(lambda1), String);
    w2:= ExpandedList(lambda2);
    w:= Concatenation(w1, w2, -Reversed(w2), Reversed(w1));
    A:= ArrangementsBn(w);

    sigma1:= AssociatedPartition(lambda2);
    sigma2:= AssociatedPartition(lambda1);
    sigma:= [sigma1, sigma2];
    u1:= List(ExpandedList(sigma1), String);
    u2:= ExpandedList(sigma2);
    u:= Concatenation(u1, u2, -Reversed(u2), Reversed(u1));
    B:= ArrangementsBn(u);

    sm:= SpechtMatrix_Bn(A, B);
    
# Need Standard Bi-tableaux
# Use Standard Bi-tableaux to find the rows and columns they are sitting in the Specht Matrix

#a:= WordsBiTableau(standard bi-tableaux);;
#List([set of WordsBiTableaux], i-> [Position(A, i[1]), Position(B, i[2])]);













    return rec(sm:= sm, A:= A, B:= B, syt:= syt, k:= k);
end;