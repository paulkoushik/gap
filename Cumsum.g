Cumsum:= function(mu)
local mu_new, n;
mu_new:= [];
n:= Length(mu);
    for i in [1..n] do
        mu_new[i]:= Sum(mu[1..i]);
    od;
return mu_new;
end;

