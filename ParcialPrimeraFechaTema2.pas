program repuestos2;
const
maxmarcas = 130;
type
rango_marcas = 1..maxmarcas;

repuesto = record
 cod: integer;
 precio: real;
 codMarca: rango_marcas;
 pais: string;
end;

lista = ^nodo;
nodo = record
 dato: repuesto;
 sig: lista;
end;

vectorMarcas = array[rango_marcas] of string; //El codigo no se guarda ya que por la posiciones del verctor ya se deduce que donde este el nombre sera el codigo de dicha marca
vectorPrecios = array[rango_marcas] of real; // Utilizo este vector por el inciso b punto 2 para almecenar precios y calcular un minimo...

procedure cargarRepuestos(var L: lista); //SE DISPONE

procedure leerMarca(var cod: integer; var nombre: string);
begin
  readln(cod);
  readln(nombre);
end;

procedure cargarMarcas(var V1: vectorMarcas); //INCISO A
var 
 i: rango_marcas;
 cod: integer;
 nombre: string;
begin
  for i:= 1 to maxmarcas do begin
    leerMarca(cod,nombre);
    v[cod]:= nombre; //En la posicion del codigo me guardo el nombre de la marca...
  end;               //Osea guardo el nombre en la posicion en el vector del codigo ingresado
end;                 //ERROR muy comun es poner [i] esto esta mal ya que no lee el codigo ingresado si no la posicion de
                     //Debido a que la informacion se lee sin ningun orden, si fuera con orden si seria con [i] ya que 
                     //tendria que ir desde el valor inicial hasta el final

procedure inicializarPrecios(var V2: vectorPrecios);
var
 i: rango_marcas;
begin
  for i:= 1 to maxmarcas do
    V2[i]:= 9999; //Incializo cada posicion del vector en un valor alto para calcular el precio minimo
end;

procedure actualizarMinimo(var min : real; nuevoPrecio: real);
begin
  if(nuevoPrecio < min) then 
    min:= nuevoPrecio;
end;

function sinCeros( cod : integer) : boolean;
var
 cantCeros : integer;
 dig: integer;
begin
 cantCeros:= 0;
 while(cod <> 0) do begin
   dig:= cod MOD 10; //Me quedo con el ultimo digito..
   cod:= cod DIV 10; //Achico el numero..
   if(dig = 0) then
     cantCeros:= cantCeros + 1;
 end;
  sinCeros:= (cantCeros < 1); //Si la cantidad de ceros es menor a 1 eso quiere decir que el codigo no tiene ceros por lo tanto es verdadero(true)..
end;

procedure procesarInformacion_Repuestos(L: lista; V1: vectorMarcas; var cantMas100,cantSinCeros: integer; 
                                             var masBarato: vectorPrecios);
var
  repuestosPorPais: integer;
  paisActual: string;
begin
  cantMas100:= 0; //inicializo las variables localmente dentro de este proceso
  cantSinCeros:= 0;
  //La informacion esta ordenada por PAIS
  while(L <> nil) do begin // Se utila un corte de control al recorrer la lista
    paisActual:= L^.dato.pais; //Me quedo con el pais que estoy procesando
    repuestosPorPais:= 0;
    while (L <> nil) and (paisActual = L^.dato.pais) do begin
      repuestosPorPais:= repuestosPorPais + 1;
      actualizarMinimo(masBarato[L^.dato.codMarca],L^.dato.precio);
      if(sinCeros(L^.dato.cod)) then
        cantSinCeros:= cantSinCeros + 1;
      L:= L^.sig; //Avanzo en la lista..
    end;
    if(repuestosPorPais > 100) then
        cantMas100:= cantMas100 + 1;
  end;
end;

var
 L: lista;
 marcas: vectorMarcas;
 masBarato: vectorPrecios; //Deduje utilizar este vector teniendo en cuenta que debo almanecar 130 precios..
 cantMas100,cantSinCeros,i: integer;
BEGIN
  cargarRepuestos(L); //Se dispone //cargarLista es lo mismo..
  cargarMarcas(marcas);  //cargarVector es lo mismo.. //INCISO A
  inicializarPrecios(masBarato);
  procesarInformacion_Repuestos(L,marcas,cantMas100,cantSinCeros,masBarato);  //INCISO B //marcas y masBarato son vectores

  writeln('La cantidad de paises a los que se les compro mas de 100 repuestos fue de: ',cantMas100);

  for i:= 1 to maxmarcas do
    writeln('El producto mas barato de la marca ',marcas[i],' tiene un precio de: ',masBarato[i]);

  writeln('La cantidad de repuestos que no poseen ningun 0 en su codigo fue de: ',cantSinCeros);

END.