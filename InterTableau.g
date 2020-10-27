InterTableau:= function(t,s)
local tt, a, uu, row, i, k;
    cols:= WordsTableau(t).cols;
    uu:= List(t[1], x -> []);
        for row in s do
            for i in [1..Length(row)] do
                a:= row[i];
                k:= cols[a];
                Add(uu[k], a);
            od;
        od;
    return TransposedMat(uu);
end;
