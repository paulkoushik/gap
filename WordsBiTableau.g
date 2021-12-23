WordsBiTableau:= function(tab)
    local rows, cols, i, k, a, b, tab1, tab2;

        rows:= [];
        cols:= [];

        #tableau 1

        tab1:= tab[1];
            for i in [1..Length(tab1)] do
                for k in [1..Length(tab1[i])] do
                    a:= tab1[i][k];
                        if a > 0 then
                            rows[a]:= String(i);
                            cols[a]:= k;
                        else
                            rows[-a]:= String(i);
                            cols[-a]:= -k;
                        fi;
                od;
            od; 


        #tableau 2

        tab2:= tab[2];
            for i in [1..Length(tab2)] do
                for k in [1..Length(tab2[i])] do
                    b:= tab2[i][k];
                        if b > 0 then
                            rows[b]:= i;
                            cols[b]:= String(k);
                        else
                            rows[-b]:= -i;
                            cols[-b]:= String(k);
                        fi;
                od;
            od;

    return List([rows, cols], MirroredWord);

end;
