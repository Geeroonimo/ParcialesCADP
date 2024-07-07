program bizzaprac;
const
maxGeneros = 5;
type
rango_generos = 1..maxGeneros;

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

vector_generos = array[rango_generos] of integer;

var
L : lista;
titulo: string;
BEGIN
  cargarSesion(L); // punto 1
  procesarSesiones(L); // inciso A,B
  readln(titulo);
  eliminarSesion(L,titulo); //inciso C
END.

procedure leerSesion(var s:sesion);
begin
  readln(s.titulo);
  readln(s.nombre);
  readln(s.genero);
  readln(s.cantVisYT)
end;

procedure insertarOrdenado(var L:lista; s: sesion);
var
 ant,act,nue: lista;
begin
  new(nue);
  nue^.dato:= s;
  act:= L;
  ant:= L;
  while(L <> nil) and (s.titulo < act^.dato.sesion) do begin
    ant:= act; //ubicas al inicio de la lista
    act:= act^.sig; // avazon a la direccion del siguiente nodo
  end;
  if(act = ant) then
    L:= nue
    else
      ant^.sig:= nue;
    nue^.sig:= act;
end;

procedure cargarSesion( var L: lista);
var
 s: sesion;
begin
  repeat
    leerSesion(s);
    insertarOrdenado(L,s);
  until(s.nombre = 'Peso Pluma');
end;

procedure inicializarVector( var v: vector_generos);
var
 i: rango_generos;
begin
  for i:= 1 to maxGeneros do
    v[i]:= 0;
end;

function cumple(visitas : integer): boolean;
var
 cantPar,cantImpar: integer;
begin
  cantPar:= 0;
  cantImpar:= 0;
  while(visitas <> 0) do begin
    if(((visitas MOD 10) MOD 2) = 0) then
      cantPar:= cantPar + 1;
      else 
        cantImpar:= cantImpar + 1;
    visitas:= visitas DIV 10;
  end;
  cumple:=(cantPar = cantImpar);
end;

procedure actualizarMaximos(v: vector_generos;  cantVisYT: integer; var codMax1,codMax2: integer);
var
 i: rango_generos;
 max1,max2: integer;
begin
  max1:= -1;
  max2:= -1;
  for i:= 1 to maxgeneros;
    if(v[i] > max1) then begin
      max2:= max1;
      codMax2:= codMax1;
      max1:= v[i]; // lo que contiene en esa posicion del vector
      codMax1:= i; //codigo de genero la iteracion del vector
    end
      else
         if(v[i] > max2) then begin
           max2:= v[i];
           codMax2:= i;
         end;
end;

procedure procesarSesiones(L: lista);
var
 genero,codMax1,codMax2: rango_generos;
 v: vector_generos;
 cantSReggaeton: integer;
begin
  inicializarVector(v);
  cantSReggaeton:= 0;
  while(L <> nil) do begin
    genero:= L^.dato.genero;
    while(L <> nil) and (L^.dato.genero = genero) do begfin
      v[genero]:= v[genero] + L^.dato.cantVisYT;
      actualizarMaximos(v[genero],L^.dato.cantVisYT,codMax1,codMax2);
      if(cumple(L^.dato.cantVisYT)) then
        cantSReggaeton:= cantSReggaeton + 1;
     L:= L^.sig;
    end;
  end;
  writeln(codMax1,codMax2); //inciso a
  writeln(cantSReggaeton); //inciso b
end;

procedure eliminarSesion(var L: lista, titulo: string);
var
 ant,act: lista;
begin
 act:= L;
 ant:= L;
 while(act <> nil) and (act^.titulo <> titulo )do begin
   act:= ant;
   act:= act^.sig;
 end;
 if(act <> nil) then begin
   if(act = L) then
     L:= L^.sig;
    else
     ant^.sig:= act^.sig;
   dispose(act);
 end;
end;