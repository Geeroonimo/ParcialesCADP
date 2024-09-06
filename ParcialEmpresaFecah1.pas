program empresa;
const
 maxCoches = 2500;
type
 rango_coches = 1000..maxCoches;
 rango_meses = 1..12;

 viaje = record
  cod: integer;
  numCoche: rango_coches;
  mes: rango_meses; //Mes en que se realizo el viaje
  cantPasajesV: integer; //Cantidad de pasajes vendidos
  dni: integer; //Dni del chofer
 end;

lista = ^nodo; //No es necesario ya que se dispone
nodo = record
 dato: viaje;
 sig: lista;
end;

//La informacion no se encuentra ordenada por ningun criterio..

vector_capacidad = array[rango_coches] of integer;
vector_viajes = array[rango_coches] of integer;

var
 L,Lmes2: lista;
 capacidad: vector_capacidad;

begin
 L:= nil;
 cargarViajes(L); //Se dispone
 inicializarCapacidad(capacidad); //Se dispone
 procesarViajes(L);
 generarLista(L,Lmes2);

end.

procedure cargarViajes(var L:lista); //Se dispone

procedure inicializarCapacidad(var c: vector_capacidad);

procedure inicializarViajes(var v:vector_viajes);
var
 i: rango_coches;
begin
  for i:= 1000 to maxCoches do
    v[i]:= 0;
end;

procedure actualizarMaximo(v: vector_viajes; var maxCoche);
var
 i: rango_coches;
 max: integer;
begin
  max:= -1;
  for i:= 1000 to maxCoches do begin
    if(v[i] > max) then begin
      max:= v[i];
      maxCoche:= i;
    end;
  end;
end;

procedure procesarViajes(var L: lista);
var
 v: vector_viajes;
 cocheActual: rango_coches;
 maxCoche: rango_coches;
begin
  inicializarViajes(v);
  maxCoche:= 0;
  while( L <> nil) do begin
   v[cocheActual]:= v[cocheActual] + 1; // 1 es el viaje echo
   actualizarMaximo(v,maxCoche);
   
   
   
   writeln(cantPasajeros / cantViajes);
   L:= L^.sig;
  end;
end;