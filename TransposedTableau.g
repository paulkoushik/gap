TransposedTableau:= function(t)
local i, j, result;
result:= List(t[1], x -> []);
  for i in [1..Length(t)] do
     for j in [1..Length(t[i])] do
     result[j][i]:= t[i][j];
     od;
  od;
return result;
end;
