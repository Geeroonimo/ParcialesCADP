program panaderia2;
const
maxCategorias = 20;
type
rango_categorias = 1..maxCategorias;

vector_categorias = array[rango_categorias] of categoria;

categoria = record //La panaderia dispone esta info
 nombre: string;
 precio: real;
end;

compra = record
 dni: integer;
 categoria: rango_categorias;
 cantKilos: integer;
end;

lista = ^nodo;
nodo = record
 dato: compra;
 sig: lista;
end;

//vector_montos = array[rango_categorias] of real;
vector_compras = array[rango_categorias] of integer;

var
 L: lista;
 V: vector_categorias;
 compras: vector_compras;
 dniMin,cantCompras: integer;
BEGIN
  cargarCategorias(V); //Se dispone
  L:= nil;
  cargarCompras(L); //inciso a
  procesarCompras(L,V,dniMin,compras,cantCompras); //inciso b
END.

procedure cargarCategorias(var V: vector_categorias);

procedure leerCompra(var c: compra);
begin
  readln(c.dni);
  readln(c.categoria);
  readln(c.cantKilos);
end;

procedure insertarOrdenado(var L:lista; c: compra);
var
act,ant,nue: lista;
begin
 new(nue);
 nue^.dato:= c;
 act:= L;
 ant = L;
 while(L <> nil) and(c.dni < act^.dato.dni) do begin
  act:= ant;
  act:= act^.sig;
 end;
 if(act = ant) then
  L:= nue;
 end;
 else
  ant^.sig:= nue;
 nue^.sig:= act;
end;

procedure cargarCompras(var L:lista);
var 
 c: compra;
begin
  leerCompra(c);
  while(c.dni <> -1) do begin
    insertarOrdenado(L,c);
    leerCompra(c);
  end;
end;

procedure inicializarVector(var v: vector_compras);
var
 i: rango_categorias;
begin
  for i:= 1 to maxCategorias do
    v[i]:= 0;
end;

function almenos5impares(dni: integer): boolean;
var
 cantImpar: integer;
begin
  cantImpar:= 0;
  while(dni <> 0) do begin
    if(((dni MOD 10) MOD 2) = 1) then
      cantImpar:= cantImpar + 1;
    dni:= dni DIV 10;
  end;
  almenos5impares:=(cantImpar >= 5);
end;

procedure actualizarMin(dni: integer; gasto: real; var dniMin: integer);
var
 min: real;
begin
 min:= 9999;
 if(gasto < min) then begin
   min:= gasto;
   dniMin:= dni;
 end;
end;
procedure procesarCompras( L:lista; v: vector_categorias; var dniMin: integer;
                              var compras: vector_compras; var cantCompras: integer);
var
 dniActual: integer;
 cantGastoActual: real;
begin
  inicializarVector(compras);
  cantCompras:= 0;
  while(L <> nil) do begin
    dniActual:= L^.dato.dni;
    cantGastoActual:= 0;
    while(L <> nil) and (L^.dato.dni = dniActual) do begin
      cantGastoActual = cantGastoActual + (L^.dato.cantKilos * v[L^.dato.categoria].precio);
      compras[L^.dato.categoria]:= compras[L^.dato.categoria] + 1; // Voy sumando una compra
      if(almenos5impares(dniActual)) then
        cantCompras:= cantCompras + 1;
     L:= L^.sig; 
    end;
    actualizarMin(dniActual,cantGastoActual,dniMin);
  end;
end;