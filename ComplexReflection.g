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
                    Add(row, YoungCharNew(u,v));
                od;
            Add(matrix, row);
        od;
return matrix;
end;


#######################################################