const
maxequipos = 28;
maxfechas = 27;
type
rango_equipos = 1 ..maxequipos;
rango_fechas = 1..maxfechas;

jugador = record
 codigo: integer;
 nyap: string; //apellido y nombre
 codEquipo: rango_equipos;
 añoNac: integer; //ano de nacimiento
 calificacion: vector_calificaciones;
end;

vector_calificaciones = array[rango_fechas] of integer;

lista = ^nodo;
nodo = record
 dato: jugador;
 sig: lista;
end;

vector_equipos = array[rango_equipos] of integer;

VAR
 L,L35: lista;
 V1: vector_equipos;
 jug1,jug2,i: integer;
BEGIN
L:= nil;
L35:= nil;
cargarLista(L); //SE DISPONE
inicializarVector(V1);
recorrerLista(L,V1,jug1,jug2);
for i:= 1 to maxequipos do begin
  writeln('El equipo: ',i,'tiene',V1[i],'jugadores de mas de 35 años');
end;
writeln(jug1,jug2);
generarLista35(L,L35);
END.

procedure cargarLista(var L:lista);

procedure inicializarVector(var v: vector_equipos);
var
 i: rango_equipos;
begin
  for i:= 1 to maxequipos;
    v[i]:= 0;
end;

procedure analizarPuntuaciones(v: vector_calificaciones; var promedio: real; var cantFechas: integer);
var
 i: rango_fechas;
 suma: integer;
begin
  suma:= 0;
  cantFechas:= 0;
  for i:= 1 to maxfechas do begin
    if(v[i] <> 0) then begin
      suma:= suma + v[i];
      cantFechas:= cantFechas + 1;
    end; 
  end;
 promedio:= suma / cantFechas;
end;

actualizarMaximos(var jug1,jug2: integer; var prom1,prom2: 
                     real; jugador : integer; prom: real;)
begin
  if(prom > prom1) then begin
    prom2:= prom1;
    jug2:= jug1;
    prom1:= prom;
    jug1:= jugador;
  end
    else
       if(prom > prom2) then begin
         prom2:= prom;
         jug2:= jugador;
       end;
end;

procedure recorrerLista(L: lista; var v: vector_equipos; var jug1,jug2: integer);
var
 prom, prom_jug1, promjug2: real;
 cant,cantJugMas35:= integer;
begin
 prom_jug1:= -1;
 prom_jug2:= -1;
  while(L <> nil) do begin
    if((2024 - L^.dato.añoNac) > 35) then
      v[L^.dato.codEquipo]:= v[L^.dato.codEquipo] + 1;
    analizarPuntuaciones(L^.dato.califiacion,prom,cant);
    if(cant > 14) then
      actualizarMaximos(jug1,jug2,prom_jug1,prom_jug2,L^.dato.codigo,prom);
  end;
end;

function tiene3impares( codigo : integer) : integer;
var
 cantImpar: integer;
begin
 cantImpar:= 0;
  while(codigo <> 0) do begin
    if(((codigo MOD 10) MOD 2) = 1) then
      cantImpar:= cantImpar + 1;
  end;
  tiene3imapres:= (cantImpar = 3);
end;

procedure insertarOrdenado(var L35: lista; j: jugador);
var
 nue: lista;
 act, ant: lista;
begin
  new(nue);
  nue^.dato:= j;
  act:= L;
  ant:= L;
  while(act <> nil) and (j.codigo <> act^.dato.codigo) do begin
    ant:= act;
    act:= act^.sig;
  end;
  if(act = ant) then
    L:= nue
  else
    ant^.sig:= nue;
  nue^.sig:= act;
end;

procedure generarLista35(L: lista; var L35: lista);
begin
  while(L <> nil) do begin
    if(tiene3impares(L^.dato.codigo) and (L^.dato.añoNac >= 1983) and (L^.dato.añoNac <=  1990)) then
        insertarOrdenado(L35,L^.dato);
    L:= L^.sig;
  end;
end;