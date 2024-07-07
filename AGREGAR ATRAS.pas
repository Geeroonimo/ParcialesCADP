procedure agregarAtras(var L, ULT: lista; D: dato);
var
 nue: lista;
begin
  new(nue);
  nue^.dato:= D;
  nue^.sig:= nil;
  if(L = nil) then
    L:= nue
  else
    ULT^.sig:= nue;
  ULT:= nue;
end;