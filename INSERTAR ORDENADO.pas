procedure agregarOrdenado(var L: lista; s : sesion);
var
 nue: lista;
 act,ant: lista; {Punteros auxiliares para el recorrido}
begin
 new(nue);
 nue^.dato:= s;
 act:= L;
 ant:= L;
 while( act <> nil) and (s.titulo < act^.dato.titulo) do // el < es una operacion determinada por el inciso
 begin
  ant:= act; {ubico act y ant al inicio de la lista}
  act:= act^.sig;
 end;
 if(act = ant) then {al inicio o lista vacia}
  L:= nue
 else {al medio o al final}
  ant^.sig:= nue; //insertas nodo mediante direcciones
 nue^.sig:= act; //insertas nodo mediante direcciones
end;