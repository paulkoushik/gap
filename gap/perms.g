perms:= function(t)
    local i, j, t1, A, B, AB, a, all, A1B1, l, m, x, perm;
        m:= [];
        i:= RowDescent(t)[1][1]; j:= RowDescent(t)[1][2];
        t1:= TransposedMat(t);
        B:= t1[j+1]{[1..i]};
        A:= t1[j]{[i..Length(t1[j])]};
        AB:= Concatenation(A, B);
        a:= Length(A);
        all:= Combinations(AB, a);
        A1B1:= List(all, x -> [x, Difference(AB, x)]);
            for x in A1B1 do
                l:= [1..Sum(t, Length)];
                l{AB}:= Concatenation(x);
                perm:= PermList(l);
                    if perm <> () then
                        Add(m, PermList(l));
                    fi;
            od;
    return m;    
end;