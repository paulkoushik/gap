BiPartitionWordBn:= function(w1)
local lambda, a, i, k;
lambda:= [[],[]];

for a in w1 do
    i:= a[2]+1;    
    k:= a[1];
        
        if IsBound(lambda[i][k]) then
            lambda[i][k]:= lambda[i][k]+1;
        else
            lambda[i][k]:= 1;
        fi;

od;

return lambda;
end;