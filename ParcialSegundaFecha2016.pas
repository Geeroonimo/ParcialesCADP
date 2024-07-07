program comercio;
const
maxProductos = 1000;
type
rango_productos = 1..maxProductos;

vector_productos = array[rango_productos] of info_producto;

info_producto = record
 descripcion: string;
 precio: real;
end;

venta = record
 codigo: integer; //codigo de la venta
 dni: integer; //dni del comprador
 codP: rango_productos; // codigo del producto
 cantProd: integer; // cantidad de unidades del producto
end;

lista = ^nodo;
nodoo = record
 dato: venta;
 sig:  lista;
end;

vector_montos = array[rango_productos] of real;

var
 L: lista;
begin
  L:= nil;
  cargarVentas(L); // inciso a, cargo la informacion de las ventas en la lista
  procesarVentas_Informar(L);
end.

procedure leerVenta(var v: venta);
begin
  readln(v.codigo);
  readln(v.dni);
  readln(v.codP);
  readln(v.cantProd);
end;

procedure agregarAdelante(var L: lista; v: venta);
var
 nue: lista;
begin
  new(nue);
  nue^.dato:= v;
  nue^.sig:= L;
  L:= nue;
end;

procedure cargarVentas(var L: lista);
var
 v: venta;
begin
  repeat
  leerVenta(v);
  agregarAdelante(L,v);
  until(v.codigo = 2121); //utilizo un repeat until por que la venta debe procesarse
end;

procedure inicializarVectores(var v: vector_montos; var v2: vector_productos);
var
 i: rango_productos;
begin
  for i:= 1 to maxProductos do
    v[i]:= 0;
    v2[i]:= 0;
end;

function almenos3pares(dni: integer): boolean;
var
 cantPares: integer;
begin
  cantPares:= 0;
  while(dni <> 0) do begin
   if(dni MOD 2 = 0) then
    cantPares:= cantPares + 1;
   dni:= dni DIV 10;
  end;
  almenos3pares:= (cantPares >= 3);
end;

procedure buscarMaxsyMins(var v: vector_productos; var codMax,codMin: integer);
var
 i: rango_productos;
 max,min: integer;
begin
 max:= -1;
 min:= 9999;
 for i:= 1 to maxProductos do begin
   if(v[i] > max) then begin
     max:= v[i];
     codMax:= i;
   end;
   if(v[i] < min) then begin
     min:= v[i];
     codMin:= i;
   end;
 end;
end;

procedure procesarVentas_Informar(L: lista);
var
 codVenta,codMax,codMin: integer;
 montoTotal: real;
 v: vector_montos;
 v2: vector_productos;
 cantVentas3pares: integer;
 
begin
  inicializarVectores(v,v2);
  while(L <> nil) do begin
   codVenta:= L^.dato.codigo;
   montoTotal:= v[codVenta].precio * L^.dato.cantProd;
   write(codVenta,montoTotal); //inciso b punto 1
   
   v2[L^.dato.codP]:= v2[L^.dato.codP] + 1; //parte del inciso b punto 2

   if(almenos3pares(L^.dato.dni)) then //inciso b punto 3
     cantVentas3pares:= cantVentas3pares + 1;
   L:= L^.sig;
  end;
 buscarMaxsyMins(v2,codMax,codMin); //parte del inciso b punto 2
 writeln(codMax,v2[codMax].descripcion); //codigo Maximo con su descripcion
 writeln(codMin,v2[codMin].descripcion); //codigo Minimo con su descripcion
 writeln(cantVentas3pares); 
end;