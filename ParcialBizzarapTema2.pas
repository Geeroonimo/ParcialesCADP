const
maxgeneros = 5;
type
rango_generos = 1..maxgeneros;

sesion = record
 titulo: string;
 nombre: string;
 genero: rango_generos;
 cantVisYT: integer;
end;

lista = ^nodo;
nodo = record
 dato: sesion;
 sig: lista;
end;

vector_generos= array[rango_generos] of integer;

procedure leerSesion(var s: sesion);
begin
  readln(s.titulo);
  readln(s.nombre);
  readln(s.genero);
  readln(s.cantVisYT);
end;

procedure agregarOrdenado(var L: lista; s : sesion);
var
 nue: lista;
 act,ant: lista; {Punteros auxiliares para el recorrido}
begin
 new(nue);
 nue^.dato:= s;
 act:= L;
 ant:= L;
 while( act <> nil) and (p.titulo < act^.dato.titulo) do
 begin
  ant:= act; {ubico act y ant al inicio de la lista}
  act:= act^.sig;
 end;
 if(act = ant) then {al inicio o lista vacia}
  L:= nue
 else {al medio o al final}
  ant^.sig:= nue;
 nue^.sig:= act;
end;

procedure cargarLista(var L: lista);
var
 s: sesion;
begin
  repeat
    leerSesion(s);
    agregarOrdenado(L,s);
  until(s.nombre = 'Peso Pluma');
end;

procedure inicializarVector(var V: vector_generos);
var
 i: rango_generos;
begin
  for i:= 1 to maxgeneros do 
   v[i]:= 0;
end;


procedure actualizarMaximos(V: vector_generos;  cantVisYT: integer; var cod1,cod2: integer);
var
 i: maxgeneros;
 max1,max2: integer;
begin
  max1:= -1;
  for i:= 1 to maxgeneros;
    if(v[i] > max1) then begin
      max2:= max1;
      cod2:= cod1;
      max1:= v[i]; // lo que contiene en esa posicion del vector
      cod1:= i; //codigo de genero la iteracion del vector
    end
      else
         if(v[i] > max2) then begin
           max2:= v[i];
           cod2:= i;
         end;
end;

function descomponer(visitas: integer) : boolean;
var
 dig: integer;
 sumaPar,sumaImpar: integer;
begin
  sumaPar:= 0;
  sumaImpar:= 0;
  while(visitas <> 0) do begin
    dig:= visitas MOD 2;
    if(dig = 0) then
      sumaPar:= sumaPar + 1;
      else
         sumaImpar:= sumaImpar + 1;
    visitas:= visitas DIV 10;
  end;
  descomponer:= (sumaPar = sumaImpar);
end;

procedure procesarSesiones(L: lista; V: vector_generos);
var
 cantSReggaeton,cod1,cod2: integer;
begin
 cantSReggaeton:= 0;
  while(L <> nil) do begin
    V[L^.dato.genero]:= V[L^.dato.genero] + L^.dato.cantVisYT;
    actualizarMaximos(V[L^.dato.genero],L^.dato.catVisYT,cod1,cod2);

    if(L^.dato.genero = 2) and (descomponer(L^.dato.cantVisYT)) then //SI EL GENERO ES REGGAETON Y LAS VISITAS CONTIENEN LA MISMA CANTIDAD DE DIGITOS PARES E IMPARES
        cantSReggaeton:= cantSReggaeton + 1;
   L:= L^.sig;
  end;
  writeln(cod1,cod2); //inciso A
  writeln(cantSReggaeton); //inciso B
end;

procedure eliminarSesion(var L: lista; Nuevotitulo: string);
var
 ant,act: lista;
begin
  act:= L;
  while(act<> nil) and (act^.dato.titulo <> Nuevotitulo)do begin
    ant:= act;
    act:= act^.sig;
  end;
  if(act <> nil) then
    if(act = L) then
      L:= L^.sig;
    else
      ant^.sig:= act^.sig;
    dispose(act);
  end;
end;

var
 L: lista;
 generos: vector_generos;
 titulo: string
BEGIN
 L:= nil;
 cargarLista(L);
 inicializarVector(generos);
 procesarSesiones(L,generos); //inciso A y B
 readln(titulo); //inciso C
 eliminarSesion(L,titulo); //inciso C
END.