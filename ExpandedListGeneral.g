




ExpandedListGeneral:= function(lambda)
local w, n, L, l, i, j;
w:= [];
n:= Sum(Sum(lambda));
L:= [0,1..(n-1)];
l:= List(lambda, ExpandedListAn);

for i in l do
    for j in i do
        Add(w, [j, L[Position(L, Position(l, l[i]))]]);
    od;
od;

return w;
end;