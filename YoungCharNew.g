YoungCharNew:= function(u, v)
local c, d, pi, i;
    c:= TransposedMat([u,v]);
    if Size(Set(c)) < Length(c) then
        return 0;
    fi;
    for i in c do
        if i[1][2] <> i[2][2] then
            return 0;
        fi;
    od;
    
    d:= ShallowCopy(c);
    pi:= Sortex(d);
    
    return SignPerm(pi);
end;
