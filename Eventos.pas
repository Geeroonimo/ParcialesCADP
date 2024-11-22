program eventos;
const
diaMax = 31;
maxCat = 4;
type
rango_dias = 1..diaMax;
rango_categorias = 1..maxCat;

reserva = record //Se dispone
 numReserva: integer;
 dni: integer;
 dia: rango_dias; // dia del evento
 horaI: integer;
 horaF: integer;
 categoria: rango_categorias;
end;

lista = ^nodo;
nodo = record
 dato: reserva;
 sig: lista;
end;

infoReserva = record
 numero: integer;
 precioTotal: real;
end;

lista2 = ^nodo2;
nodo2 = record
 dato: infoReserva;
 sig: lista2;
end;

vector_precios = array[rango_categorias] of real;

vector_reservas = array[rango_dias] of integer;

var
L,L2: lista;
L2: lista2
precioXhora: vector_precios;
begin
L:= nil;
cargarLista(L); // Se dispone
cargarPreciosPorHora(precioXhora); // Se dispone
procesarReservas(L,precioXhora,L2);

end.

procedure cargarLista(var L: lista); // Se dispone
procedure cargarVector(var v: vector_precios); //Se dispone

procedure inicializarV2(var v2: vector_reservas);
var
 i: rango_dias;
begin
  for i:= 1 to diaMax do
    v[i]:= 0;
end;

function cumple(inicio,final: integer): boolean
begin
  cumple:=(inicio < 12) and (final = 12);
end;

procedure actualizarMaximos(v: vector_reservas; var diaMax1,diaMax2: rango_dias);
var
 i: rango_dias
 max1,max2: integer;
begin
 max1:= -1;
 max2:= max1;
  for i:= 1 to diaMax do begin
    if(v[i] > max1) then begin
      max2:= max1;
      diaMax2:= diaMax1;
      max1:= v[i];
      diaMax1:= i;
      else
        if(v[i] > max2) then begin
          max2:= v[i];
          diaMax2:= i;
        end;
    end;
  end;
end;

procedure insertarOrdenado(var L2: lista2; r: reserva);
var
 nue: lista2;
 act,ant: lista2;
begin
new(nue);
nue^.dato:= r;
act:= L2;
ant:= L2;
while(act <> nil) and (r.numero <> act^.dato.numero) do begin
  ant:= act;
  act:= act^.sig;
end; 
if(act = ant) then
  L2:= nue;
  else
   ant^.sig:= nue;
  nue^.sig:= act;
end;

function esPar(dni: integer): Boolean
var
 dig: integer;
begin
  while(dni <> 0) do begin
    dig:= dni MOD 10;
    if(dig MOD 2 = 0) then
      esPar:= true;
      else
        esPar:= false;
    dni:= dni DIV 10;
  end;
end;

procedure procesarReservas(L: lista; v: vector_precios; var L2: lista);
var
 v2: vector_reservas;
 diaMax1,diaMax2: rango_dias;
 cantRCumplen: integer; // Cantidad de reservas que cumplen
 cantRTotales: integer;
 reserva: infoReserva;
 numero: integer;
 precioTotal: real;
begin
  inicializarV2(v2);
  cantRTotales:= 0;
  while(L <> nil) do begin
    numero:= L^.dato.numReserva;
    cantRTotales:= cantRTotales + 1;

    precioTotal:= (L^.dato.horaF - L^.dato.horaI) * v[L^.dato.categoria];

    if(esPar(L^.dato.dni)) then
      v2[L^.dato.evento]:= v2[L^.dato.evento] + 1 // Le sumo una reserva

    if(cumple(L^.dato.horaI,L^.dato.horaF) and (L^.dato.dia >= 1) and (L^.dato.dia <= 15)) then
       cantRCumplen:=  cantRCumplen + 1;   
    L:= L^.sig;

  end;
  reserva.numero:= numero;
  reserva.precioTotal:= precioTotal;
  insertarOrdenado(L2, reserva);

  actualizarMaximos(v2,diaMax1,diaMax2)
  writeln(diaMax1,diaMax2);
  writeln(CantRCumplen*100/cantRTotales:2:2);
end;