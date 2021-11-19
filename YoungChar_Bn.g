##The input of the function should be a Group element of a type B_n group 
##as a subgroup of S_2n group.

YoungChar_Bn:= function(w)
    local n, list, l, pi;
    
        n:= (LargestMovedPoint(w) + SmallestMovedPoint(w)-1)/2;
        list:= (ListPerm(w){[1..n]} + n) mod (2*n + 1) - n;
        l:= List(list, AbsInt);
        pi:= PermList(l);

    return SignPerm(w * pi);
end;

