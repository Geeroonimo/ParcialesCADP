program supermercado2;
const
maxaño = 2024;
type
rango_años = 1980..maxaño;

compra = record
 codigo: integer;
 año: rango_años;
 monto: real;
 dni: integer;
end;

lista = ^nodo;
nodo = record
 dato: compra;
 sig: lista;
end;

vector_montos = array[2010..2020] of real;

var
L,L2: lista;
begin
L:= nil;
cargarLista(L);
cargarComprasEntre2010y2020(L,L2);
procesarCompras(L2); //Entre 2010 y 2020
end.

procedure cargarLista(var L); //Se dispone

procedure insertarOrdenado(var L2: lista; c : compra);
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

procedure cargarComprasEntre2010y2020(L: lista; var L2: lista);
begin
  while(L <> nil) do begin
    if((L^.dato.año >= 2010) and (L^.dato.año <= 2020)) then
       insertarOrdenado(L2,L^.dato);
    L:= L^.sig;
  end;
end;

procedure actualizarMin(v: vector_montos; var peorAño);
var
 i: integer;
 min: real;
begin
 min:= 9999;
  for i:= 2010 to 2020 do
    if(v[i] < min) then begin //El vector tiene almacenado el monto por cliente
      min:= v[i];
      peorAño:= i;
    end;
  end;
end;

procedure actualizarMaximos(dniActual:integer; comprasActual: integer; var dniMax1,dniMax2: integer);
var
 max1,max2: integer;
begin
max1:= -1;
max2:= -1;
if(comprasActual > max1) then begin
  max2:= max1;
  dniMax2:= dniMax1;
  max1:= comprasActual;
  dniMax1:= dniActual;
  else if(comprasActual > max2) then begin
    max2:= comprasActual;
    dniMax2:= dniActual;
  end;
end;
end;

procedure procesarCompras(L2: lista);
var
 dniActual: integer;
 cantCompras10,cantComprasActual,peorAño: integer;
 v: vector_montos;
 dniMax1,dniMax2: integer;
 montoTotal: real;
begin
  inicializarVector(v);
  cantCompras10:= 0;
  while(L2 <> nil) do begin //Se empieza a recorrer la lista
    dniActual:= L^.dato.dni;
    cantComprasActual:= 0;
    while(L2 <> nil) and (dniActual = L^.dato.dni) do begin
      cantComprasActual:= cantComprasActual + 1;
      v[L^.dato.año]:= v[L^.dato.año] + L^.dato.monto;
      if(L^.dato.codigo MOD 10 = 0) then // manera de hacerlo sin llamar una funcion..
        cantCompras10:= cantCompras10 + 1;
     L2:= L2^.sig;
    end;
    actualizarMaximos(dniActual,cantComprasActual,dniMax1,dniMax2);
  end;
 actualizarMin(v,peorAño);
 writeln(peorAño); //informo todo
 writeln(cantCompras10);
 writeln(dniMax1,dniMax2);
end;