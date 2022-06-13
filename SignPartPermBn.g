
SignPartPermBn:= function(sigma)
local n, list, l, pi, l1, l2, ll, pi0, p, p0, int;

    if sigma <> () then
        n:= (LargestMovedPoint(sigma) + SmallestMovedPoint(sigma)-1)/2;
        list:= (ListPerm(sigma, 2*n) + n) mod (2*n + 1) - n;
        l:= List(list, AbsInt);
        l1:= l{[n+1..2*n]};
        l2:= -l1 mod (2*n+1);
        l{[n+1..2*n]}:= l2;
        ll:= l;
        pi:= PermList(ll); 
        pi0:= sigma/pi;
        p:= MovedPoints(pi0);
        p0:= p{[1..Length(p)/2]};
        
        int:= [1..n];
        int{p0}:= -p0;
            
    return List(int, i -> SignInt(i));

    else
        return sigma;
    fi;
end;