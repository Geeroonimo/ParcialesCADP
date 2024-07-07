procedure agregarAdelante(var L: lista; D: dato);
var
 nue: lista;
begin
  new(nue);
  nue^.dato:= D;
  nue^.sig:= L;
  L:= nue;
end;