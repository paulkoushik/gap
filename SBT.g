SBT:= function(lambda1, lambda2)
local ;

lambda:= [lambda1, lambda2];
list:= [];

### Standard Bi-Tableaux have entries only from {1,2,3,...,n}.
### They don't contain entries {n+1, n+2,..., 2n} = {-n, -(n-1),..., -1}

    if Length(lambda2) = 0 then
        return SYT(lambda1);
    fi;

# have to arrange the second tableau having the remaining elements arranged 
# increasingly on rows and then starts filling the next row and so on...

    if Length(lambda2) > 0 then
        Add[list, SYT(lambda1)]




    syt2:= SYT(lambda2);