const
maxgeneros = 5;
type
rango_generos= 1..maxgeneros;
sesion = record
 titulo: string;
 nombre: string;
 genero: rango_generos;
 visitasYT: integer;
end;

lista = ^nodo;
nodo = record
 dato: sesion;
 sig: lista;
end;

vector_generos = array[rango_generos] of integer;

VAR
L: lista;
V: vector_generos;
titulo: string;
BEGIN
L:= nil;
cargarLista(L);
inicializarVector(V);
procesarSesiones(L,V);
readln(titulo);
eliminarTitulo(L,titulo);
END.

procedure leerSesion(var s: sesion);
begin
  readln(s.titulo);
  readln(s.nombre);
  readln(s.genero);
  readln(s.visitasYT);
  end;
end;

procedure insertarOrdenado(var L: lista; s: sesion);
var
 act,ant,nue: lista;
begin
 new(nue);
 nue^.dato:= s;
 act:= L;
 ant:= L;
 while(act <> nil) and (s.titulo < act^.dato.titulo) do
   begin
     ant:= act;
     act:= act^.sig;
   end;
   if(act = ant) then
     L:= nue;
   else
      ant^.sig:= nue;
   nue^.sig:= act;
end;

procedure cargarLista(var L: lista);
var
 s: sesion;
begin
  repeat
   leerSesion(s);
   insetarOrdenado(L,s);
  until(s.nombre = 'Peso Pluma');
end;

procedure inicializarVector(var v: vector_generos);
var 
 i: rango_generos;
begin
  for i:= 1 to maxgeneros do
    v[i]:= 0;
end;

procedure actualizarMaximos( v: vector_generos: var cod1,cod2: rango_generos);
var
 i: rango_categorias;
 max1,max2: integer;
begin
 max1:= -1;
 max2:= -1;
 for i:= 1 to maxgeneros do begin
  if(v[i] > max1) then begin
    max2:= max1;
    cod2:= cod1;
    max1:= v[i]; //Elementos que tiene guardado el vector en esa posicion
    cod1:= i; //Posicion del vector
  end
   else if(v[i] > max2) then begin
      max2:= v[i];
      cod2:= i;
   end;
 end;
end;

function descomponer( visitas: integer): integer;
var
 dig: integer;
 cantPar,cantImpar: integer;
begin
 cantPar:= 0;
 cantImpar:= 0;
 while(visitas <> 0) do begin
  dig:= visitas MOD 10; //extraigo ultimo digito
  if(dig MOD 2 = 0) then
    cantPar:= cantPar + 1;
    else 
      cantImpar:= cantImpar + 1;
  visitas:= visitas DIV 10; //achico el numero
 end;
 descomponer:= (cantPar = cantImpar);
end;

procedure procesarSesiones(L: lista; V: vector_generos);
var
 cod1,cod2: rango_generos;
 genero: rango_generos;
 cantReggaeton: integer;
begin
 cantReggaeton:= 0;
  while(L <> nil) do begin
    genero:= L^.dato.genero;
    V[genero]:= V[genero] + L^.dato.visitasYT;
    actualizarMaximos(v[genero],cod1,cod2);
    if((genero = 2) and (descomponer(L^.dato.visitasYT)) then
      cantReggaeton:= cantReggaeton + 1;
    L:= L^.sig;
  end;
  writeln(cod1,cod2);
  writeln(cantReggaeton);
end;

procedure eliminarTitulo(L: lista; Nuevotitulo: string);
var
 act,ant: lista;
begin
 act:= L;
 while(act <> nil) do begin
  if(act^.titulo <> Nuevotitulo) then begin
   ant:= act;
   act:= act^.sig;
  end;
  else begin
    if(act = L) then 
      L:= L^.sig;
    else 
      ant^.sig:= act^.sig;
    dispose(act);
    act:=ant;
  end;
end;