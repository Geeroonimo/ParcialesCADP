program supermercado;
const
maxmeses = 12;
maxaño = 2024;
type
rango_meses = 1..maxmeses;
rango_años = 2014..maxaño;

compra = record
 codigo: integer;
 mes: rango_meses;
 año: rango_años;
 monto: real;
 dni: integer;
end;

lista = ^nodo;
nodo = record
 dato: compra;
 sig: lista;
end;

vector_montos = array[rango_meses] of real;

var
L,L2: lista;
año: rango_años;
montos: vector_montos;
begin
L:=nil;
cargarCompras(L); //Se dispone
readln(año);
cargarComprasDelAño(L,año,L2);
procesarComprasPorAño(L2);
end.

procedure cargarCompras(L); //Se dispone

procedure agregarOrdenado(var L2: lista; c : compra);
var
 nue: lista;
 act,ant: lista; {Punteros auxiliares para el recorrido}
begin
 new(nue);
 nue^.dato:= c;
 act:= L2;
 ant:= L2;
 while( act <> nil) and (c.dni < act^.dato.dni) do // el < es una operacion determinada por el inciso
 begin
  ant:= act; {ubico act y ant al inicio de la lista}
  act:= act^.sig;
 end;
 if(act = ant) then {al inicio o lista vacia}
  L2:= nue
 else {al medio o al final}
  ant^.sig:= nue;
 nue^.sig:= act;
end;

procedure cargarComprasDelAño(L: lista; año: rango_años; var L2: lista);
var
begin
L2:= nil;
while(L <> nil) do begin
  if(L^.dato.año = año) then
    agregarOrdenado(L2,L^.dato);
 L:= L^.sig;
end;
end;

procedure actualizarMinimos( v: vector_montos; var mes1,mes2: integer);
var
 i: rango_meses;
 min1,min2:= integer;
begin
  min1:= 9999;
  min2:= 9999;
  for i:= 1 to maxmeses do begin
    if(v[i] < min1) then begin
      min2:= min1;
      mes2:= mes1;
      min1:= v[i];
      mes1:= i;
    end
    else 
     if(v[i] < min2) then begin
       min2:= v[i];
       mes2:= i;
    end;
  end;
end;

procedure inicializarVector(var v: vector_montos);
var
 i:rango_meses;
begin
  for i:= 1 to maxmeses do 
    v[i]:= 0;
end;

function esMultiploDe10(codigo : integer): boolean;
begin
 esMultiploDe10:= ((codigo MOD 10) =0);
end;

procedure procesarComprasPorAño(L2: lista; var v: vector_montos);
var
 dniActual:= integer;
 v: vector_montos;
 montoTotal: real;
 mes1,mes2: rango_meses;
 cantComprasMax,cantCompras10: integer;
begin
  inicilizarVector(v); //inicializo el vector de montos en 0
  cantCompras10:= 0;
  while(L2 <> nil) do begin
    dniActual:= L2^.dato.dni;
    montoTotal:= 0; // se declara dentro de la lista ya que te pide para cada cliente
    while(L2 <> nil) and (dniActual = L2^.dato.dni) do begin
      montoTotal:= montoTotal + L2^.dato.monto;
      v[L^.dato.mes]:= v[L^.dato.mes] + L2^.dato.monto;
      if(esMutiplode10(L^.dato.codigo)) then
        cantCompras10:= cantCompras10 + 1;
    L2:= L2^.sig;    
    end;
    writeln('Para el cliente ',dniActual,' el monto total fue: ',montoTotal:2:2);
  end;
  actualizarMinimos(v,mes1,mes2);
  writeln(mes1,mes2); //inciso b punto 2
  writeln(cantCompras10); //inciso b punto 3
end.