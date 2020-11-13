#One can create Specht matrix for any partition of a number n.
##########################################################################################################################
##########################################################################################################################

## For any given partition lambda, one can find the word corresponding to the partition lambda
## Input any partition as a list argument in the function to find the word corresponding to it

ExpandedList:= function(P)
    local i, p, W;
        W:= [];
            for p in [1..Length(P)] do
                for i in [1..P[p]] do
                    Add(W, p);
                od;
            od;
    return W;
end;

###########################################################################################################################

# For any given tableau, one can find the corresponding row and column words 
# Row and column words can be found by giving the tableau as a list of lists in the argument 

WordsTableau:= function(tableau)
local rows, cols, i, k, a;
    rows:= [];
    cols:= [];
        for i in [1..Length(tableau)] do
            for k in [1..Length(tableau[i])] do
                a:= tableau[i][k];
                rows[a]:= i;
                cols[a]:= k;
            od;
        od;
return rec(rows:= rows, cols:= cols);
end;

###########################################################################################################################

# For any number n, a Young tableau is an arrangement of boxes in a tetris like shape corresponding to a partition of n and each box has a number from 1,..,n.
# A standard Young tableau is when the numbers 1,2,..,n inside the boxes and they are increasing towards the right on the rows and towards the bottom on columns.

###########################################################################################################################

# A canonical tableau is a standard Young tableau, which has all its rows and columns properly sorted.
# i.e., assigning the numbers to the boxes first fills out the row 1 and then moves to the second row and so on in an ascending order to the right.
# To find the canonical tableau for any partition lambda, input lambda in the argument

CanonicalTableau:= function(lambda)
local t, o, l;
    t:= [];
    o:= 0;
        for l in lambda do
            Add(t, o + [1..l]);
            o:= o + l;
        od;
    return t;
end;

###########################################################################################################################

# To find a Young tableau for any partition lambda, input the lambda as an argument in the function

RandomTableau:= function(lambda)
local n, t, a, tt;
    n:= Sum(lambda);
    t:= CanonicalTableau(lambda);
    a:= Random(SymmetricGroup(n));
    tt:= OnTuplesTuples(t,a);
return tt;
end;

###########################################################################################################################

# Input a partition lambda in the argument to find out a standard Young tableau of shape lambda

RandomSYT:= function(lambda)
local n, t, a, t1, t2, tt;
    n:= Sum(lambda);
    t:= CanonicalTableau(lambda);
    a:= Random(SymmetricGroup(n));
    tt:= OnTuplesTuples(t, a);
    t1:= List(tt, Set);
    t2:= TransposedMat(List(TransposedMat(t1), Set));
return t2;
end;

###########################################################################################################################

# To find the set of all standard Young tableaux of shape lambda, input the partition lambda in the argument.

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

###########################################################################################################################

# A tabloid is basically the set of all tableaux obtained by applying all permutations of the elements present in the same rows or same columns.
# To obtain the row tabloid (the elements in the rows are permuted and assigned in the same rows) for any particular tableau, one can input the tableau as a list in the argument.

RowTabloid:= function(t)
  return Cartesian(List(t, row -> Arrangements(row, Length(row))));
end;

###########################################################################################################################

# For each partition lambda, there exists a conjugate partition sigma where both lambda and sigma are partitions of a number n.
# One can obtain the conjugate partition sigma of a partition lambda by flipping the rows and columns of the lambda-tableaux and then considering the partition for the transposed tableau.
# Lambda and sigma may or may not be the same partitions, it depends on the selection of the partition lambda.
# For any tableau corresponding to a partition lambda, one can find the tableau corresponding to the conjugate partition of lambda, i.e., sigma, by an input of the original tableau as a argument in the function

TransposedTableau:= function(t)
local i, j, result;
result:= List(t[1], x -> []);
  for i in [1..Length(t)] do
     for j in [1..Length(t[i])] do
     result[j][i]:= t[i][j];
     od;
  od;
return result;
end;

###########################################################################################################################




