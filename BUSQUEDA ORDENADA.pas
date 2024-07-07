function busquedaOrdenada(L: lista; VALOR: dato) : boolean;
var
 encontre: boolean;
begin
 encontre:= false;
 while(L <> nil) and (L^.dato <> VALOR) do begin
   L:=L^.sig;
 end;
 if(L <> nil) and (L^.dato = VALOR) then
   encontre:= true;
 end;
 busquedaOrdenada:= encontre;
end;