SYT:= function(lambda)
    local   isOneHook,  removeOneHook,  addOneHook,  n,  list,  i,
            new,  t;

    isOneHook:= function(lambda, i)
        return i = Length(lambda) or lambda[i] > lambda[i+1];
    end;

    removeOneHook:= function(lambda, i)
        local new;
        if i = Length(lambda) and lambda[i] = 1 then
            return lambda{[1..i-1]};
        fi;
        new:= ShallowCopy(lambda);
        new[i]:= new[i]-1;
        return new;
    end;

    addOneHook:= function(t, i, n)
        if i > Length(t) then
            Add(t, [n]);
        else
            Add(t[i], n);
        fi;
        return t;
    end;

    # trivial case first
    if lambda = [1] then
        return [[[1]]];
    fi;

    # initialize
    n:= Sum(lambda);
    list:= [];

    # loop
    for i in Reversed([1..Length(lambda)]) do
        if isOneHook(lambda, i) then
            new:= removeOneHook(lambda, i);
            for t in SYT(new) do
                addOneHook(t, i, n);
                Add(list, t);
            od;
        fi;
    od;

    return list;
end;
