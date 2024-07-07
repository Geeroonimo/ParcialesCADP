procedure imprimirLista(L: lista);
begin
  while(L <> nil) do begin
    writeln(L^.dato);
    L:= L^.sig;
  end;
end;