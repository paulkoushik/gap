MirroredWord:= function(w)

local w1, w2, i;

w1:= [];
w2:= [];

for i in w do
    Add(w1, i);
        if IsInt(i) then
            Add(w2, -i);
        else
            Add(w2, i);
        fi;
od;

return Concatenation(w1, Reversed(w2));

end;