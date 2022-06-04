SignChangeMatBn:= function(u1, spechtobject)
local matlist, list, m, i;

matlist:= [];
list:= PermPartBn(u1);
    for i in list do 
        if list[AbsInt(i)] < 0 then
            m:= DiagonalMat( ListWithIdenticalEntries(n, (-1)^spechtobject.A[1][AbsInt(i)][2]));
            Add(matlist, m);
        fi;
    od;

return Product(matlist);
end;


