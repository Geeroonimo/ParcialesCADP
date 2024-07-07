program repuestos;
const
maxpaises = 200;
type
rango_paises= 1..maxpaises;

nombrePaises = array[rango_paises] of string;

 repuesto = record
  cod: integer;
  precio: real;
  codPais: rango_paises;
 end;
 
 lista = ^nodo;
 nodo = record
  dato: repuesto;
  sig: lista;
 end;
 
vectorCantRepuestos = array[rango_paises] of integer;
vectorPrecios = array[rango_paises] of real;

// procedure cargarVector(var V: nombrePaises); //SE DISPONE

procedure leerRepuesto(var r: repuesto);
begin
  readln(r.cod);
  readln(r.precio);
  readln(r.codPais);
end;

procedure agregarAdelante(var L : lista; r: repuesto);
var
 aux : lista;
 begin
  new(aux);
  aux^.dato:= r;
  aux^.sig:= L;
  L:= aux; 
 end;

procedure cargarLista(var L: lista);
var
 r: repuesto;
begin
 leerRepuesto(r);
  while(r.cod <> -1) do begin
    agregarAdelante(L,r); //Es por que la informacion no te pide ordenarla de cierta forma por lo tanto se carga como viene
    leerRepuesto(r);
  end;
end;

procedure inicializarDatos(var comprasPorPais: vectorCantRepuestos; var masCaros: vectorPrecios; var cant3Ceros: integer);
var
 i,cant3Ceros: integer;
begin
  for i:= 1 to maxpaises do begin
    comprasPorPais[i]:= 0;
    masCaros[i]:= 0;
  end;
cant3Ceros:= 0;
end;

function alMenos3Ceros(num : integer) : boolean; // descomponer un numero y verificar cuantos 0 tiene
var 
 cantCeros: integer;
 dig: integer;
begin
cantCeros:= 0;
  while(num <> 0) do begin
    dig:= num MOD 10;
    num:= num DIV 10;
    if(dig = 0) then
      cantCeros:= cantCeros + 1;
  end;
  alMenos3Ceros:= (cantCeros >= 3);
end;

procedure actualizarMax(var max: real; nuevoPrecio: real);
var
begin
 if(nuevoPrecio > max) then 
   max:= nuevoPrecio; 
end;

function cantidadArribaDelPromedio(v: vectorCantRepuestos) : integer;
var
 promedio: real;
 suma,i,cant: integer;
begin
suma:= 0; {Necesito recorrer el vector 2 veces}
 for i:= 1 to maxpaises do // La primera vez lo recorro para calcular el promedio sumando todos los repuestos de cada pais
   suma:= suma + v[i]
 promedio:= suma / maxpaises;

 cant:= 0;
 for i:= 1 to maxpaises do //La segunda para verificar cuantos superan el promedio
  if(v[i] > promedio) then
    cant:= cant + 1;
 cantidadArribaDelPromedio:= cant;
end;

procedure procesarInformacion(v : nombrePaises; L: lista; var comprasPorPais: vectorCantRepuestos; var masCaros: vectorPrecios; 
                     var cant3Ceros: integer);
var
 paisActual: integer;
begin
  while(L <> nil) do begin
    paisActual:= L^.dato.codPais; //Codigo del pais actual ingresado
    comprasPorPais[paisActual]:= comprasPorPais[paisActual] + 1; // El 1 representa un repuesto
    actualizarMax(masCaros[paisActual],L^.dato.precio);
    if(alMenos3Ceros(L^.dato.cod)) then
      cant3Ceros:= cant3Ceros + 1;

    L:= L^.sig; //Avanzo al siguiente nodo de la lista
  end;
end;

var 
 vector_paises: nombrePaises;
 L: lista;
 comprasPorPais: vectorCantRepuestos;
 masCaros: vectorPrecios;
 i,cant3Ceros : integer;
begin
  cargarVector(vector_paises); // Se dispone
  cargarLista(L);
  inicializarDatos(comprasPorPais,masCaros,cant3Ceros); //Proceso para inicializar los vectores y la variable cant3ceros
  procesarInformacion(vector_paises, L, comprasPorPais, masCaros, cant3Ceros); // vector_paises y L se envian por valor y lo demas te lo retorna
  writeln('La cantidad de paises para los que la cantidad de repuestos comprados es menor que el promedio entre todos los paises es de: ',cantidadArribaDelPromedio(comprasPorPais));
  for i:= 1 to maxpaises do begin
    writeln('El repuesto mas caro del pais', vector_paises[i],'tiene un precio de', masCaros[i]);
  end;
  writeln('La cantidad de respuestos que poseen al menos 3 ceros en su codigo es de: ', cant3Ceros);
end.