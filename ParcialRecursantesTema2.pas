program alumnosRecursantes;
const
notaMax = 10;
type
rango_notas = 1..notaMax;

alumno = record
 dni: integer;
 AyN: string; //Apellido y nombre
 añoI: integer; //Año de ingreso
 nota: vector_notas;
end;

vector_notas = array[rango_notas] of integer;

lista = ^nodo;
nodo = record
 dato: alumno;
 sig: lista;
end;

var
 L: lista;
begin
  L:= nil;
  cargarLista(L); // inciso A
  procesarAlumnos(L); //inciso B
end.

procedure leerNota(var v: vector_notas);
var
 i: rango_notas;
begin
  for i:= 1 to notaMax do
    readln(v[i])
end;

procedure leerAlumno(var a: alumno);
begin
  readln(a.dni); //dni del alumno
  readln(a.AyN); //Apellido y nombre del alumno
  readln(a.añI); //Año de ingreso del alumno
  leerNota(a.nota); //Nota del alumno
end;

procedure agregarAdelante(var L:lista; a: alumno);
var
 nue: lista;
begin
  new(nue);
  nue^.dato:= a;
  nue^.sig:= L;
  L:= nue;
end;
procedure cargarLista(var L: lista);
var
 a: alumno;
begin
  repeat
    leerAlumno(a);
    agregarAdelante(L,a)
  until(a.dni = 33016244);
end;

procedure analizarAutoeval(v: vector_notas; var presentes,aprobadas: integer);
var
 i: rango_notas;
begin
  for i:= 1 to notaMax do begin
    if(v[i] > 0) then begin
      presentes:= presentes + 1;
      if(v[i] >= 6) then
        aprobadas:= aprobadas + 1;
  end;
end;

function esPar( dni: integer): boolean;
var
 dig,suma: integer;
begin
  suma:=0;
  while(dni <> 0) do begin
    dig:= dni MOD 10;
    suma:= suma + dig; //Sumo los digitos
    dni:= dni DIV 10;
  end;
  esPar:=(suma MOD 2 = 0);
end;

function porcentaje( alumnos,totalAlumnos: integer): real;
begin
  porcentaje:=(alumnos * 100 / totalAlumnos);
end;
procedure procesarAlumnos(L: lista; var cantAlumnos: integer);
var
 dniAlumno: integer;
 presentes,aprobadas: integer;
 cantAlumnos,cantTotalAlumnos: integer;
begin
 cantAlumnos:= 0;
 cantTotalAlumnos:= 0;
  while(L <> nil) do begin
    cantTotalAlumnos:= cantTotalAlumnos + 1;
    dniAlumno:= L^.dato.dni;
    analizarAutoeval(L^.dato.nota,presentes,aprobadas); //como primer dato le paso el dato de tipo vector con las notas cargadas
    if((presentes >= 8) and (aprobadas >= 4)) then
      writeln(dniAlumno); //punto 1
    if((L^.dato.añoI = 2020) and (presentes = notaMax)) then
      cantAlumnos:= cantAlumnmos + 1; //parte del punto 2
    if(esPar(dniAlumno)) then
      writeln(L^.dato.AyN); //punto 3
  end;
writeln(porcentaje(cantAlumnos,cantTotalAlumnos));
end;
// Al recorrer la lista sumo la cantidadTotal de alumnos
// En una estructura if sumo la cantidad de alumnos bajo cierttas condiciones
// Luego creo un modulo porcentaje pasandole estas dos cantidades de alumnos..