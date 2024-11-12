program preinscripciones;
const
maxMes = 12;
maxHorario = 4;
type

rango_meses = 1..maxMes;
rango_horarios = 1..maxHorario;

nacimiento = record
 dia: integer;
 mes: rango_meses;
 ano: integer;
end;
preinscripcion = record
 dni: integer;
 AyN: string[20];
 fechaN: nacimiento;
 telefono: integer;
 horario: rango_horarios;
end;

lista = ^nodo;
nodo = record
 dato: preinscripcion;
 sig: lista;
end;

vector_horarios = array[rango_horarios] of integer;

var
 L: lista;
begin
  cargarLista(L); //Inciso A
  procesarPreinscripciones(L); //Inciso B
end.

procedure cargarLista(var L: lista);
var
 p: preinscripcion; ULT: lista;
begin
  leerPreinscripcion(p);
  while(p.dni <> -1) do begin
    agregarAtras(L,ULT,p);
    leerPreinscripcion(p);
  end;
end;

procedure leerNacimiento(var n: nacimiento);
begin
  readln(n.dia);
  readln(n.mes);
  readln(n.ano);
end;

procedure leerPreinscripcion(var p: preinscripcion);
begin
  readln(p.dni);
  if(p.dni <> -1) then begin
    readln(p.AyN);
    leerNacimiento(p.fechaN);
    readln(p.telefono);
    readln(p.horario);
  end;
end;

procedure agregarAtras(var L: lista; ULT: lista; p: preinscripcion);
var
 nue: lista;
begin
 new(nue);
 nue^.dato:= p;
 nue^.sig:= nil;

 if(L = nil) then
   L:= nue
  else
    ULT^.sig:= nue;
 ULT:= nue;
end;

procedure inicializarVector(v: vector_horarios);
var
 i: rango_horarios;
begin
  for i:= 1 to maxHorario do
    v[i]:= 0;
end;

function cumple(mes : rango_meses): boolean;
begin
  cumple:= (mes > 1) and (mes < 7); // Si nacieron entre enero y junio es verdadero
end;

function todosImpares(dni : integer): boolean;
var
 dig: integer;
begin
dig:= 0;
todosImpares:= true; // Se asume que todos los digitos son impares
while (dni <> 0) do begin
  dig:= dni MOD 10; // Tomo ultimo digito
  if(dig MOD 2 = 0) 
    todosImpares:= false;
  dni:= dni DIV 10; // Eliminamos el ultimo digito (achico dni)
end;
end;

procedure actualizarMaximos(v: vector_horarios; var maxH1,maxH2: rango_horarios);
var
 i: rango_horarios
 max1,max2: integer;
begin
max1:= -1;
max2:= max1;
  for i:= 1 to maxHorario do begin
    if(v[i] > max1) then begin
      max2:= max1;
      maxH2:= maxH1;
      max1:= v[i];
      maxH1:= i;
      else
         if(v[i] > max2) then begin
           max2:= v[i];
           maxH2:= i;
         end;
    end;
  end;
end;

procesarPreinscripciones(L : lista);
var
 Horarios: vector_horarios;
 cantAlumnosCumplen: integer;
 cantPTotal: integer; //Cantidad de preinscripciones totales..
 cantPCumplen: integer; //Cantidad de preinscripciones al horario jornada completa (4)

begin
inicializarVector(Horarios);
cantAlumnosCumplen:= 0;
cantPTotal:= 0;
cantPCumplen:= 0;
 while(L <> nil) do begin
   cantPTotal:= cantPTotal + 1; //Cantidad de preinscripciones totales..
   if(cumple(L^.dato.fechaN.mes)) then
    cantAlumnosCumplen:= cantAlumnosCumplen + 1; //Cantidad de preinscripciones al horario jornada completa (4)

   Horarios[L^.dato.horario]:= Horarios[L^.dato.horario] + cantAlumnosCumplen;
   if(todosImpares(L^.dato.dni)) then begin
     writeln(L^.dato.AyN);
     writeln(L^.dato.telefono);
   end;
   if(L^.dato.horario = 4) then
     cantPCumplen:= cantPCumplen + 1;
  L:= L^.sig;
 end;
 actulizarMaximos(Horarios,maxHorario1,maxHorario2);
 writeln(maxHorario1,maxHorario2);
 writeln(cantPCumplen * 100 / cantPTotal:2:2);
end;