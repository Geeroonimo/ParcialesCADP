program tienda;
const
  maxNivel = 5;
type
 rango_nivel = 1..maxNivel;

cliente = record
 numero: integer;
 dni: integer;
 AyN: string;
 fechaN: integer;
 nivel: rango_nivel;
 puntaje: integer;
end;

lista = ^nodo;
 nodo = record
  dato: cliente;
  sig: lista;
 end;

vector_puntaje = array[rango_nivel] of integer;

var
 L,L2: lista;
 numero: integer;
begin
  cargarLista(L);
  generarLista2(L,L2); //inciso a
  procesarClientes(L); //iniciso b
  readln(numero); //inciso c
  eliminarNumeroCliente(L2,numero); //inciso c
end.

procedure leerCliente(var c: cliente);
begin
  readln(c.numero);
  readln(c.dni);
  readln(c.AyN);
  readln(c.fechaN);
  readln(c.nivel);
  readln(c.puntaje);
end;

procedure agregarAdelante( var L:lista; c: cliente);
var
 nue: lista;
begin
 new(nue);
 nue^.dato:= c;
 nue^.sig:= L;
 L:= nue;
end;

procedure cargarLista( var L:lista);
var
 c: cliente;
begin
  repeat
    leerCliente(c);
    agregarAdelante(L,c);
  until(c.dni = 33444555);
end;

function cumple( dni: integer): boolean; // chequear modulo
var
 dig,cantImpares: integer;
 todosImpares: boolean;
begin
  todosImpares:= false;
  cantImpares:= 0;
  while( dni <> 0) do begin
    dig:= dni MOD 10;
    if(dig MOD 2 = 1) then
      cantImpares:= cantImpares + 1;
    dni:= dni DIV 10;
    todosImpares:= true;
  end;
  cumple:= todosImpares; 
end;

{procedure insetarOrdenado(var L2: lista; c:cliente);
var
 ant,act,nue: lista;
begin
  new(nue);
  nue^.dato:= c;
  act:= L;
  ant:= L;
  while(act <> nil) and(c.)
end;
}

procedure generarLista2(L: lista; var L2: lista);
begin
  while(L <> nil) do begin
    if(cumple(L^.dato.dni)) then
        insertarOrdenado(L2,L^.dato); //consultar como cargar esta lista
    L:= L^.sig;
  end;
end;

procedure inicializarVector(var v:vector_puntaje);
var
 i: rango_nivel;
begin
  for i:= 1 to maxNivel do begin
    v[i]:= 0;
  end;
end;

procedure actualizarPuntuajes(v: vector_puntaje; var maxNivel,minNivel: integer);
var
 i: rango_nivel;
 max: integer;
 min: integer;
begin
 max:= -1;
 min:= 9999;
 for i:= 1 to maxNivel do begin
   if(v[i] > max) then begin
     max:= v[i];
     maxNivel:= i;
   end;
   if(v[i]) < min) then begin
     min:= v[i];
     minNivel:= i;
   end;
 end;
end;

procedure procesarClientes(L: lista);
var
 i: rango_nivel;
 maxPuntaje,minPuntaje: integer; 
 v: vector_puntaje;
begin
  maxPuntaje:= 0;
  minPuntaje:= 0;
  inicializarVector(v);
  while(L <> nil) do begin
    v[L^.dato.nivel]:= v[L^.dato.nivel] + L^.dato.puntaje;
    if(L^.dato.fechaN < 2000) then
      actualizarPuntajes(v[L^.dato.nivel],maxNivel,minNivel);
    L:= L^.sig;
  end;
  writeln('El nivel con mayor puntaje es el: ',maxNivel,' y con menor puntaje el ',minNivel);;
end;

procedure eliminarNumeroCliente(var L2: lista; numero: integer); //no se si pasarle la primer lista cargada o la segunda con la condicion..
var
 ant,act: lista;
begin
  act:= L;
  ant:= L;
  while( act <> nil) and (act^.dato.numero <> numero) do begin
    ant:= act;
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