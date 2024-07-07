//EJER SIN LISTA
const
maxempleados = 2000;
maxpais = 25;
type
rango_empleados = 1..maxempleados;
rango_pais = 1..maxpais;

empleado = record
 cod: rango_empleados;
 codPais: rango_pais;
 anos: integer;
 sueldo: real;
end;

info_sueldo = record
 codigo: rango_empleados;
 sueldo: real;
end;

vector_paises = array[rango_pais] of integer;
vector_sueldos = array[rango_pais] of info_sueldo;


lista = ^nodo;
nodo = record
 dato: empleado;
 sig: lista;
end;

var
 L: lista;
 empleadosPais : vector_paises;
 mejorSueldos: vector_sueldo;
 cantEmpleados: integer;
BEGIN
  cantEmpleados:= 0;
  cargarLista(L);
  inicializarVectores(empleadosPais,mejorSueldos,cantEmpleados);
  procesarEmpleados(L,empleadosPais,mejorSueldos);
END.

procedure leerEmpleado(var e: empleado);
begin
    readln(e.cod);
  if(e.cod <> 0) then begin
    readln(e.codPais);
    readln(e.anos);
    readln(e.sueldo);
  end;
end;

procedure agregarOrdenado(var L: lista; e: empleado);
var
 nue: lista;
 ant,act: lista;
begin
 new(nue);
 nue^.dato:= e;
 ant:= L;
 act:= L;
 while(act <> nil) and (e.codPais < act^.dato.codPais) do begin
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
 e: empleado;
begin
  leerEmpleado(e);
  while(e.cod <> 0) do begin
    agregarOrdenado(L,e);
    leerEmpleado(e);
  end;
end;

procedure inicializarVectores(var sueldos: vector_sueldos; var paises: vector_paises);
var
 i: rango_empleados;
begin
  for i:= 1 to maxpais do
    vector_sueldos[i]:= 0;
    sueldos[i]:= -1;
  end;
end;

procedure actualizarMaximo(paises : vector_paises; empleados: integer; var maxPais: integer);
var
 i: rango_pais;
 max: integer;
begin
max:= -1;
  for i:= 1 to maxpais do begin
    if(v[i] > max) then begin
      max:= v[i];
      maxpais:= i;
    end;
  end;
end;

procedure buscarCodigos(Maxsueldos: vector_sueldos; sueldo: real; var codigo: integer);
var
 i: rango_pais;
begin
  for i:= 1 to maxpais do begin
    if(Maxsueldos[i] > sueldo) the begin
      sueldo:= MaxSueldos[i];
      codigo:= i;
    end;
  end;
end;

procedure procesarEmpleados(L: lista; sueldos: vector_sueldos; paises: vector_paises; mejorSueldos: vector_sueldo);
var
 pais: integer;
 empleadosPorPais: integer;
 maxPais: integer;
 cantEmpleados: integer;
begin
  while(L <> nil) do begin
    pais:= L^.dato.codPais;
    while(L <> nil) and (pais = L^.dato.codPais)do begin
      empleadosPorPais:= empleadosPorPais + 1;
      actualizarMaximo(paises[pais],empleadosPorPais,maxPais);
      if(L^.dato.anos > 10) and (L^.dato.sueldo <= 1500) then
           cantEmpleados:= cantEmpleados + 1;
      buscarCodigos(mejorSueldos[pais],L^.dato.sueldo,codigos);
    L:= L^.sig;       
    end;
  end;
  writeln('El pais con mayor cantidad de empleados es: ',maxPais); //En parcial writeln(maxPais);
  writeln('La cantiadad de empleados que superan lo de 10 anos de antiguedad con un sueldo menor o igual a 1500 fue de: ',cantEmpleados);
  writeln('')
end;