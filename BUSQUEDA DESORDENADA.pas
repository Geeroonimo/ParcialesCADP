
function busquedaDesordenada(L: lista; VALOR: dato): boolean;
var
 encontre: boolean;
begin
 encontre:= false;
 while(L <> nil) and (encontre = false) do begin
   if(L^.dato = VALOR) then
     encontre:= true;
   else
    L:= L^.sig;
 end;
 busquedaDesordenada:= encontre;
end;