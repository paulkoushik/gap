RowTabloid:= function(t)
  return Cartesian(List(t, row -> Arrangements(row, Length(row))));
end;
