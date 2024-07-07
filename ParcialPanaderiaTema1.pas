program panaderia;
const
maxCategorias = 26;
type
rango_categorias = 1..maxCategorias;

vector_categorias = array[rango_categorias] of categoria;

categoria = record
 nombre: string;
 precio: real; //precio por kilo
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

vector_montos = array[rango_categorias] of real;

var
L: lista;
V: vector_categorias;
dniMax,cantCompras: integer;
montos: vector_montos;
begin
  cargarCompras(L); //Se dispone
  cargarCategorias(V); //inciso a
  procesarCompras(L,V,dniMax,montos,cantCompras); //inciso b
end.

procedure cargarCompras(var L:lista); //Se dispone

procedure leerCategoria(var cat: categoria; var cod: integer);
begin
  readln(cat.nombre);
  readln(cat.precio);
  readln(cod);
end;

procedure cargarCategorias(var v: vector_categorias); //Cargo el vectorCategorias con la informacion de las categorias..
 i, cod: rango_categorias;
 cat: categoria;
begin
  for i:= 1 to maxCategorias do 
    leerCategoria(cat,cod); //Me retorna ambas
    v[cod]:= cat; //En la posicion del codigo cargo la info de la categoria ya leida
end;

procedure actualizarMaximo( dni: integer; compras: integer; var dniMax: integer);
var
 max: integer;
begin
max:= -1;
 if(compras > max) then begin
   max:= compras;
   dnimax:= dni;
 end;
end;

function almenos3pares( dni: integer) : boolean;
var
 cantPares: integer;
begin
 cantPares:= 0;
  while(dni <> 0) do begin
    if(((dni MOD 10) MOD 2) = 0) then
      cantPares:= cantPares + 1;
    dni:= dni DIV 10;
  end;
  almenos3pares:=(cantPares >= 3);
end;


procedure inicialzarMontos(var v: vector_montos);
var 
 i: rango_categorias;
begin
  for i:= 1 to maxCategorias do
    v[i]:= 0;
end;
procedure procesarCompras(L: lista; V: vector_categorias; var dniMax: integer
                           var montos: vector_montos; var cantCompras);
var
 dniActual,cantComprasActual: integer;
begin
 inicializarMontos(montos);
 cantComprasMax:= 0;
 cantCompras:= 0;
 while(L <> nil) do begin
   dniActual:= L^.dato.dni;
   cantComprasActual:= 0;
   while(L <> nil) and (L^.dato.dni = dniActual) do begin
     cantComprasActual:= cantComprasActual + 1;
     montos[L^.dato.categoria]:= montos[L^.dato.categoria] + 
              (L^.dato.cantKilos * v[L^.dato.categoria].precio);
     if(almenos3pares(dniActual)) then
       cantCompras:= cantCompras + 1;
     L:= L^.sig;  
   end; //Ya termine de procesar el dni del cliente actual por lo tanto..
  actualizarMaximo(dniActual,cantComprasActual,dniMax);
 end;
end;

//Solo retorno los datos procesados al programa principal, no los informo..