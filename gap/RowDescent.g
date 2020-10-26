RowDescent:= function ( t )
    local i, j, l;
    l := [  ];
    for i in [1..Length(t)] do
        for j in [1..Length(t[i])-1] do
            if t[i][j] > t[i][j+1] then 
                Add(l, [i,j]);
            fi;
        od;
    od;
    return l;
end;
