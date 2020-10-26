TransposedTabloid:= function(t)
return List(RowTabloid(t), row -> TransposedTableau(row));
end;
