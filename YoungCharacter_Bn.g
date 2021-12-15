



YoungChar_Bn:= function(w1, w2)


        c:= TransposedMat([w1, w2]);


        if Size(Set(c)) < Length(c) then
            return 0;
        fi;

        p:= Set(c, x -> Number(x, IsInt));

        if p <> [1] then 
            return 0;
        fi;
        
        n:= (LargestMovedPoint(w1) + SmallestMovedPoint(w1)-1)/2;
        list:= (ListPerm(w){[1..n]} + n) mod (2*n + 1) - n;
        l:= List(list, AbsInt);
        pi:= PermList(l); 

        return SignPerm(w * pi);
end;




