#Takes input as a pair of type-B_n words in S_2n and gives output as {-1,0,1}
#which decides the sign of the permutation applied on the input pair 
#to sort it back to the canonical pair of words

#Requires to read BiPartitionWord.g before giving the inputs 

YoungCharacter_Bn:= function(w1, w2)
    local c, p, n, list, l, pi, lambda, t, t1, t2, pi0, u1;



        c:= TransposedMat([w1, w2]);

        if Size(Set(c)) < Length(c) then
            return 0;
        fi;

#Checks the criterion for the row letter and the column letter types in a column 
#of the pair of input words, if of same type -> returns 0
#otherwise goes to the next loop

        p:= Set(c, x -> Number(x, IsInt));

        if p <> [1] then 
            return 0;
        fi;

#sorts the pair back to the canonical pair and 
#returns the sign of the permutation applied to do so       

        lambda:= BiPartitionWord(w1);
        t1:= CanonicalTableau(lambda[1]);
        t2:= CanonicalTableau(lambda[2]) + Sum(lambda[1]);

        t:= [t1, t2];
        
        w:= WordsBiTableau(t);
        pi0:= Sortex(ShallowCopy(TransposedMat(w)));
        pi:= Sortex(ShallowCopy(c));
        u1:= pi/pi0;

        if u1 <> () then
            n:= (LargestMovedPoint(u1) + SmallestMovedPoint(u1)-1)/2;
            list:= (ListPerm(u1){[1..n]} + n) mod (2*n + 1) - n;
            l:= List(list, AbsInt);
            pi:= PermList(l); 

            return SignPerm(u1 * pi);

        else
            return 1;
        fi;
end;




