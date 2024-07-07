procedure recorrerLista(L: lista);
begin
  while(L <> nil) do begin
    L:= L^.sig;
  end;
end;