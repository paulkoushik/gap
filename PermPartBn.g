
PermPartBn:= function(u1)
local n, list, l, pi, l1, l2, ll, pi0, p, p0, int;
        if u1 <> () then
            n:= (LargestMovedPoint(u1) + SmallestMovedPoint(u1)-1)/2;
            list:= (ListPerm(u1) + n) mod (2*n + 1) - n;
            l:= List(list, AbsInt);
            l1:= l{[n+1..2*n]};
            l2:= -l1 mod (2*n+1);
            l{[n+1..2*n]}:= l2;
            ll:= l;
            pi:= PermList(ll); 
            pi0:= u1/pi;
            p:= MovedPoints(pi0);
            p0:= p{[1..Length(p)/2]};
            
            int:= [1..n];
            int{p0}:= -p0;
            
            return int;

        else
            return u1;
        fi;
    end;