TypeB_nGen:= function(n)
local i, gen, j, list;

list:= [1..2*n];
gen:= [];

for i in [1..n-1] do
    for j in Reversed(list){[1..n-1]} do
        Add(gen, (i,i+1)(j,j-1));
    od;
od;

return gen;

end;















# gen:= [];
# list:= [1..2*n];
#b:= Length(list);

#sigma:= (1,2n);


#for i in list do
    
    
    
    
 #   l:= Add(gen, sigma);
  #  Add(l, (i,i+1)())

