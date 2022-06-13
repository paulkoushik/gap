SignMatBn:= function(specht, sigma)
local n, so, l, sign, index, ind, M;

    n:= (LargestMovedPoint(sigma) + SmallestMovedPoint(sigma)-1)/2;
    l:= List(specht.k, i -> i[1]);
    sign:= SignPartPermBn(sigma);
    index:= List(specht.A{l}, i -> i[1][2]);
    ind:= List(specht.A{l}, i -> Product([1..n], j -> sign[j]^i[j][2]));
    M:= DiagonalMat(ind);

return M;
end;