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




#BPWord:= function(w)
#local lambda, a;
#lambda:= [[],[]];
#    for a in w do                   
#        if a[2]=1 then
#            if IsBound(lambda[2][a[1]]) then
#                   lambda[2][a[1]]:= lambda[2][a[1]]+1;
#            else
#                   lambda[2][a[1]]:= 1;
#            fi;
#        else
#            if IsBound(lambda[1][a[1]]) then
#                   lambda[1][a[1]]:= lambda[1][a[1]]+1;
#            else
#                   lambda[1][a[1]]:= 1;
#            fi;
#        fi;
#    od;
#return lambda;
#end;