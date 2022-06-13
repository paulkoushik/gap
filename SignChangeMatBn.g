SignChangeMatBn:= function(sigma, spechtobject)
local matlist, list, m, i;

matlist:= [];
list:= SignPartPermBn(sigma);
    for i in list do 
        if list[AbsInt(i)] < 0 then
            m:= DiagonalMat( ListWithIdenticalEntries(n, (-1)^spechtobject.A[1][AbsInt(i)][2]));
            Add(matlist, m);
        fi;
    od;

return Product(matlist);
end;


