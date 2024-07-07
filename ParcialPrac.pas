const
maxaviones = 2500;
type
cod_aviones = 1000..maxaviones;

viaje = record
 codigo: cod_aviones;
 ano: integer;
 cant_pasajeros: integer;
 ciudad: string;
end;

vector_capacidad = array[cod_aviones] of integer;
//La info no se encuentra ordenada puedo optar por usar

lista = ^nodo;
nodo = record
 dato: viaje;
 sig: lista;
end;

var
  L1,L2: lista;
  V,viajesPorAvion,totalPasajeros: vector_capacidad;
  i,codMax: cod_aviones;
BEGIN
  L:= nil;
  cargarLista(L1); //Se dispone
  cargarVector(V); //SE DISPONE
  procesarViajes(L1,V,viajesPorAvion,L2,totalPasajeros);
  codMax:= maximo(viajesPorAvion);
  writeln(codMax);
  writeln(L2);
  for i:= 1000 to maxaviones do
     writeln(i,promedio(totalPasajeros[i]),viajesPorAvion[i]);
END.

procedure cargarLista(var L: lista); //Se dispone

procedure cargarVector(var V: vector_capacidad); // SE DISPONE

function maximo(viajes: vector_capacidad) : integer;
var
 i,codMax: cod_aviones;
 max: integer;
begin
 max:= -1;
  for i:= 1000 to maxaviones;
   if(viajes[i] > max) then begin
     max:= viajes[i];
     codMax:= i;
   end;
   maximo:= codMax;
end;

function promedio(pasajeros,viajes: integer) : real;
begin
 if(viajes > 0) then
  promedio:= pasajeros / viajes;
  else
    promedio:= 0;
end;

procedure inicializarVectores(var v1,v2: vector_capacidad);
var
 i: cod_aviones;
begin
  for i:= 1000 to maxaviones do begin
    v1[i]:= 0;
    v2[i]:= 0;
  end;
end;

function cumple(via: viaje; v: vector_capacidad) : boolean;
begin
  cumple:= ((via.ano MOD 10 = 0) and (via.ciudad = 'Punta Cana') and (via.cant_pasajeros < v[via.codigo]));             // SON TRES CONDICIONES
end;

procedure agregarAdelante(var L2: lista; v: viaje);
var
 nue: lista;
begin
new(nue);
nue^.dato:= v;
nue^.sig:= L2;
L2:= nue; 
end;

procedure procesarViajes(L1: lista; V: vector_capacidad; var viajes: vector_capacidad; var L2: lista; var pasajeros: vector_capacidad);
var
 avionActual: cod_aviones;
 viajesPorAvion: integer;
begin
 L2:= nil;
 inicializarVectores(viajes,pasajeros);
 viajesPorAvion:= 0;
  while(L <> nil) do begin
    avionActual:= L^.dato.codigo;
    viajes[avionActual]:= viajes[avionActual] + 1;
    pasajeros[avionActual]:= pasajeros[avionActual] + L^.dato.cant_pasajeros;
    if(cumple(L^.dato,V)) then
      agregarAdelante(L2,L^.dato);
    L:= L^.sig;    
    end;
  end;
end;