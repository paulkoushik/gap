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

