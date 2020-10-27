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
