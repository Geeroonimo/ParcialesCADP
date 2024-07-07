procedure EliminarConRepeticiones(L: lista; VALOR: dato);
var
 act,act: lista;
begin
  act:= L;
  ant:= L;
  while(act <> nil) do begin
    if(act^.dato <> VALOR) then begin
      ant:= act;
      act:= act^.sig;
    end;
    else begin
      if(act = L) then begin
        L:= act^.sig;
        ant:= L;
      end;
      else
       ant^.sig:= act^.sig;
      dispose(act);
      act:= ant;
    end;
  end;
end;

//EL elemento pueda estar o no estar depende que diga el inciso