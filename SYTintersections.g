SYTintersections:= function(lambda)
    return List(SYT(lambda), x -> List(SYT(lambda), j -> IntersectionTableau(x,j)));
end;

SubSM:= function(lambda)
    return List(SYTintersections(lambda), x -> List(x, Size));
end;