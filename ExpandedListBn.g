

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