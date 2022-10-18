SpechtMatrix:= function(A1, A2)
    local u, v, matrix, row;
    matrix:= [];
        for u in A1 do
            row:= [];
                for v in A2 do
                    Add(row, YoungCharacter(u,v));
                od;
            Add(matrix, row);
        od;
return matrix;
end;


#SpechtMatrix:= function(A1, A2)
#   return List(A1, a -> List(B, b -> YoungCharacter(a,b)));
#end;
