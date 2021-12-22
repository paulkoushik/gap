BiPartitionWord:= function(w1)
local lambda, a;
lambda:= [[],[]];

for a in w1{[1..Length(w1)/2]} do
    if IsInt(a) then 
        a:= AbsInt(a);

        if IsBound(lambda[2][a]) then
            lambda[2][a]:= lambda[2][a]+1;
        else
            lambda[2][a]:= 1;
        fi;

    else 

        a:= Int(a);

        if IsBound(lambda[1][a]) then
            lambda[1][a]:= lambda[1][a]+1;
        else
            lambda[1][a]:= 1;
        fi;
    fi;
od;

return lambda;
end;

