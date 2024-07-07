program fifa;
const
 maxPartidos = 52;
type
rango_partidos = 1..maxPartidos;

gol = record
 numPartido: rango_partidos;
 pais: string;
 numCamiseta: integer;
end;

lista = ^nodo;
nodo = record 
 dato: gol;
 sig: lista;
end;

vector_partidos = array[rango_partidos] of partido;

partido = record
 num: rango_partidos;
 estadio: string;
 nomPaises: string; //nombre de los dos paises
end;

var
L: lista; //Se dispone
V: vector_partidos;

BEGIN
  L:= nil;
  cargarGoles(L); //Se dispone
  cargarPartidos(V); //inciso a
  procesarGoles_Partidos(L,V);
END.

procedure cargarGoles( var L: lista);

procedure leerPartido( var p: partido; var num: integer);
begin
  readln(p.num);
  readln(p.estadio);
  readln(p.nomPaises);
end;

procedure cargarPartidos( var v: vector_partidos);
var
 i: rango_partidos;
 p: partido;
begin
  for i:= 1 to maxPartidos do begin
    leerPartido(p,num);
    v[num]:= p;
  end;  
end;

function cumple( estadio: string): boolean;
begin
  cumple:= (estadio = 'San Paolo');
end;

procedure analizarPartidos( v: vector_partidos; var goles: integer);
var
 i: rango_partidos;
begin
  for i:= 1 to maxPartidos do
    if(v[])
end;

procedure procesarGoles_Partidos( L:lista; v: vector_partidos);
var
 paisActual: string;
 cantPartidos5,cantGolesActual: integer;
begin
  cantPartidos5:= 0;
  while( L <> nil) do begin
    paisActual:= L^.dato.pais;
    cantGolesActual:= 0;
    while(L <> nil) and (L^.dato.pais = paisActual) do begin
      cantGolesActual:= cantGolesActual + 1;
      analizarPartidos(v[paisActual],cantGolesActual) //me devuelve los goles
      if(cantGolesActual > 5) then
        cantPartidos5:= cantPartidos5 + 1;
      if(cumple(v[paisActual].estadio) and (L^.dato.numCamiseta = 9)) then
        writeln(paisActual);
      L:= L^.sig;

    end;
  end;
  writeln(cantPartidos5); //cantidad de partidos con mas de 5 goles
end;