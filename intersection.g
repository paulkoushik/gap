RowTabloid:= function(t)
    return Cartesian(List(t, row -> Arrangements(row, Length(row))));
end;

ColumnTabloid:= function(t)
    return Cartesian(List(TransposedMat(t), row -> Arrangements(row, Length(row))));
end;

CTTransposed:= function(t)
    return List(ColumnTabloid(t), row -> TransposedMat(row));
end;

IntersectionTableau:= function(t1, t2)
    return Intersection(CTTransposed(t1), RowTabloid(t2));
end;
