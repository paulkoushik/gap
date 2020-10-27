YoungCharacter:= function(u, v)
    local c, d, pi;
        c:= TransposedMat([u,v]);
            if Size(Set(c)) < Length(c) then
                return 0;
            fi;
        d:= ShallowCopy(c);
        pi:= Sortex(d);
    return SignPerm(pi);
end;
