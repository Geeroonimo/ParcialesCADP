procedure EliminarSinRepeticiones(var L: lista; VALOR: dato);
var
    act, ant: lista;
begin
  ant:= L;
  act:= L;
  while(act <> nil) and (act^.dato <> VALOR) do begin
    ant:= act; // anterior toma la misma direccion de actual
    act:= act^.sig; //actual pasa al siguiente nodo
  end;
  if(act <> nil) then begin
   if(act = L) then //si act no tiene la direccion del primer nodo de la lista
     L:= L^.sig
   else
     ant^.sig:= act^.sig; //donde este parado anterior en ^sig toma la direccion de act^.sig
  dispose(act); //Eliminas el elmento una vez encontrado y act por que guarda la direccion
  //del primer nodo de la lista o no..
  end;
end;

//EL elemento pueda estar o no estar depende que diga el inciso