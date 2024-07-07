program pracTercerFecha;
const
maxEquipos = 28;
maxFechas = 27;
type
rango_equipos = 1..maxEquipos;
rango_fechas = 1..maxFechas;


jugador = record
 cod: integer;
 NyA: string; //Nombre y apellido
 codEquipo: rango_equipos;
 anoNac: integer; //Ano de nacimiento
 calificacion: vector_calificaciones;
end;

vector_calificaciones = array[rango_fechas] of integer;
vector_equipos = array[rango_equipos] of integer;

lista = ^nodo;
nodo = record
 dato: jugador;
 sig: lista;
end;

var
L,L2: lista;
v : vector_equipos;
jug1,jug2: integer;
begin
 L:= nil;
 L2:= nil;
  cargarJugadores(L); //Se dispone
  inicializarVector(V);
  procesarJugadores(L,V,jug1,jug2);
  imprimir(V);
  writeln(jug1,jug2);
  generarLista2(L,L2);
end.

procedure cargarJugadores(var L: lista); //se dispone

procedure inicializarVector(var v: vector_equipos);
var
 i: rango_equipos;
begin
  for i:= 1 to maxEquipos do
    v[i]:= 0;
end;

procedure analizarPuntuaciones(v: vector_calificaciones; var promedio: real; var fechas: integer)
var
 i: rango_fechas;
 suma: integer;
begin
  suma:= 0;
  for i:= 1 to maxFechas do begin
    if(v[i] <> 0) then begin
      suma:= suma + v[i];
      fechas:= fechas + 1;
    end;
  end;
 promedio:= suma / fechas;

end;

procedure actualizarMaximos(var jug1,jug2: integer; var prom1,prom2: real; jugador :integer: promedio:real);
begin
  if(promedio > prom1) then begin
    jug2:= jug1;
    prom2:= prom1;
    prom1:= promedio;
    jug1:= jugador;
  end
   else 
      if(promedio > prom2) then begin
        prom2:= promedio;
        jug2:= jugador;
      end;
end;

procedure procesarJugadores(L: lista; var v: vector_equipos; var jug1,jug2: integer;);
var
 prom_jugador1,prom_jugador2,prom: real;
 cant: integer;
begin
 prom_jugador1:= -1;
 prom_jugador2:= -1;
  while(L<> nil) do begin
    if((2024 - L^.dato.anoNac) > 35) then
      v[L^.dato.codEquipo]:= v[L^.dato.codEquipo] + 1;

    analizarPuntuaciones(L^.dato.calificaciones,prom,cant);
    if(cant > 14) then 
      actualizarMaximos(jug1,jug2,prom_jugador1,prom_jugador2,L^.dato.cod,prom);
  end;

end;

procedure imprimir(v: vector_equipos);
var
 i: rango_equipos;
begin
  for i:= 1 to maxEquipos do
    writeln('El equipo',i,'tiene una cantidad de: ',v[i],' jugadores mayores a 35 anos');
end;

function tiene3digitosImpares( cod: integer) : boolean;
var
 cantImpar: integer;
begin
 cantImpar:= 0;
  while(cod <> 0) do begin
    if(((cod MOD 10) MOD 2) = 1) then
      cantImpar:+ cantImpar + 1;
    cod:= cod DIV 10;
  end;
 tiene3digitosImpares:= ( cantImpar = 3);
end;

procedure insertarOrdenado(var L2: lista; j: jugador);
var
nue,ant,act: lista;
begin
  new(nue);
  nue^.dato:= j;
  act:= L2;
  ant:= L2;
  while( act <> nil) and (j.cod < act^.dato.cod) do begin
    ant:= act;
    act:= act^.sig;
  end;
  if(act = ant) then
    L2:= nue;
   else 
    ant^.sig:= nue;
  nue^.sig:= act;
end;

procedure generarLista2(L: lista, var L2: lista);
begin
  while(L<> nil) do begin
    if(tiene3digitosImpares(L^.dato.cod) and (L^.dato.anoNac >= 1983) and (L^.dato.anoNac <= 1990) then
      insertarOrdenado(L2,L^.dato);
    L:= L^.sig;
  end;
end;