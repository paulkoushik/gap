StandardCoefficient:= function(t, syt)
local k, list, lambda, rd, pi, Perms, tt;
lambda:= List(t, Size);
list:= ListWithIdenticalEntries(Size(syt), 0);
rd:= RowDescent(t);
    if rd = [] then
        k:= Position(syt, t);
        list[k]:= 1;
    else
        Perms:= perms(t);
        tt:= TransposedMat(List(TransposedMat(t), x -> Set(x)));
            for pi in Perms do
                list:= list + StandardCoefficient(OnTuplesTuples(tt, pi), syt) * SignPerm(pi);
            od;
    fi;
    return list;
end;

 

