program automoviles;
const
 maxModelo = 10;
type
 rango_modelos = 1..maxModelo;

 pieza = record
  codPieza: integer;
  descripcion: string[20];
  cantStock: integer;
  costo: real;
  codModelo: rango_modelos;
  StockMinimo: integer;
 end;

 lista = ^nodo;
 nodo = record
  dato: pieza;
  sig: lista;
 end;

vector_costos = array[rango_modelos] of real;

 var
  L:lista;
  
begin
  cargaPieza(L); // Inciso A
  procesarPiezas(L); // Inciso B
end.

procedure leerPieza(var p: pieza);
begin
  readln(p.codPieza);
  readln(p.descripcion);
  readln(p.cantStock);
  readln(p.costo);
  readln(p.codModelo);
  readln(p.StockMinimo)
end;

procedure agregarAdelante(L: lista; var p: pieza);
var
 nue: lista;
begin
  new(nue);
  nue^.dato:= p;
  nue^.sig: L;
  L:= nue;
end;

procedure cargarPieza(var L:lista);
var
 p: pieza;
begin
  repeat
    leerPieza(p);
    agregarAdelante(L,p);
  until(p.codPieza = 9999);
end;


procedure inicializarCostos(v: vector_costos);
var 
 i: rango_modelos;
begin
  for i:= 1 to maxModelo do
    v[i]:= 0;
end;

procedure actualizarMinimos(v: vector_costos; var minModelo1,minModelo2: rango_modelos);
var
 i: rango_modelos;
 min1,min2: integer;
begin
min1:= 9999;
min2:= min1;

  for i:= 1 to maxModelo do begin
    if(v[i] < min1) then begin
      min2:= min1;
      minModelo2:= minModelo1;
      min1:= v[i];
      minModelo1:= i;
      else 
         if(v[i] < min2) then begin
           min2:= v[i];
           minModelo2:= i;
         end;
    end;
  end;
end;

function cumple(codModelo,codPieza: integer): boolean;
begin
  cumple:= (codModelo = 3) and (codPiezas MOD 10 = 9);
end;
 
procedure procesarPiezas(L: lista);
var
 masBaratos: vector_costos;
 modelo: rango_modelos;
 minModelo1,minModelo2: integer;
 cantPiezasCumplen,cantPiezasTotal: integer;
begin
  inicializarCostos(masBaratos);
  cantPiezasTotal:= 0;
  cantPiezasCumplen:= 0;
  while (L <> nil) do begin
    masBaratos[modelo]:= masBaratos[modelo] + L^.dato.costo;
cantPiezasTotal:= cantPiezasTotal + 1;   if(cumple(L^.dato.codModelo,L^.dato.codPieza)) then
      cantPiezasCumplen:= cantPiezasCumplen + 1;
    
    if(L^.dato.cantStock >)


    L:= L^.sig;
  end;
actualizarMinimos(masBaratos,minModelo1,minModelo2); 
writeln(minModelo1,minModelo2);
writeln(cantPiezasCumplen/cantPiezasTotal);
writeln('Codigo: ')
end;