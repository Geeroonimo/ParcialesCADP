const
maxcategorias = 4;
type
rango_categorias = 1..maxcategorias;

producto = record
 codigo: integer;
 descripcion: string;
 categoria: rango_categorias;
 marca: string;
 precio: real;
end;

lista = ^nodo;
nodo = record
 dato: producto;
 sig: lista;
end;

//vectorMarcas= array[]
vectorCategorias = array[rango_categorias] of integer;

var
L: lista;
V: vectorCategorias;
BEGIN
cargarProductos(L);
cargarCategorias(V);
procesar_Datos(L,V);
END.

procedure leerProducto(var p: producto);
begin
  readln(p.codigo);
if(p.codigo <> -1) then begin //Manera de asegurar bien la lectura de datos
  readln(p.descripcion);
  readln(p.categoria);
  readln(p.marca);
  readln(p.precio);
end;
end;

procedure agregarOrdenado(var L: lista; p : producto);
var
 nue: lista;
 act,ant: lista; {Punteros auxiliares para el recorrido}
begin
 new(nue);
 nue^.dato:= p;
 act:= L;
 ant:= L;
 while( act <> nil) and (p.marca < act^.dato.marca) do
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

procedure cargarProductos(var L : lista); // INCISO A
var
 p: producto;
begin
  leerProducto(p);
  while(p.codigo <> -1) do begin
   agregarOrdenado(L,p);
   leerProducto(p);
  end;
end;

procedure cargarCategorias(var V: vectorCategorias);
var
 i: rango_categorias;
begin
  for i:= 1 to maxcategorias do begin
    V[i]:= 9999;
  end;
end;

procedure procesar_Datos(L: lista; menosProductos: vectorCategorias);
var
 marcaActual: string;
 productosPorMarca: integer;
begin
  while(L <> nil) do begin
    marcaActual:= L^.dato.marca;
    productosPorMarca:= 0;
    while(L <> nil) and (marcaActual = L^.dato.marca) do begin
      productosPorMarca:= productosPorMarca + 1;
      actualizarMinimo(menosProductos[L^.dato.categoria],)
    end;
  end;

end;