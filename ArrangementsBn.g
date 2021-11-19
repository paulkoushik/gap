#lambda:= [lambda0, lambda1];

#w0:= List(ExpandedList(lambda0), String);
#w1:= ExpandedList(lambda1);

#w:= Concatenation(w0, w1, -Reversed(w1), Reversed(w0));

ArrangementsBn:= function(w)
return Orbit(CoxeterB(Length(w)), w, Permuted);
end;




