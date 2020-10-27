WordsTableau:= function(tableau)
local rows, cols, i, k, a;
    rows:= [];
    cols:= [];
        for i in [1..Length(tableau)] do
            for k in [1..Length(tableau[i])] do
                a:= tableau[i][k];
                rows[a]:= i;
                cols[a]:= k;
            od;
        od;
return rec(rows:= rows, cols:= cols);
end;

