BlockMatCRG:= function(lambda)
local n, M, o, i, a, mat;
n:= Sum(List(lambda, i -> Sum(i)));
M:= NullMat(n,n);
o:= 0;
for i in lambda do
    for a in i do
        if a = 1 then
            mat:= [[E(n)]];
            
        else
            mat:= PermutationMat(PermList(([1..a] mod a) + 1), a);
            mat[a][1]:= E(n);
        fi;

        M{o+[1..a]}{o+[1..a]}:= mat;
        o:= o + a;
    od;
od;
return M;
end;

