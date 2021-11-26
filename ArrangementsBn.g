#lambda:= [lambda1, lambda2];

#w0:= List(ExpandedList(lambda1), String);
#w1:= ExpandedList(lambda2);

#w:= Concatenation(w1, w2, -Reversed(w2), Reversed(w1));

ArrangementsBn:= function(w)
return Orbit(CoxeterB(Length(w)/2), w, Permuted);
end;




