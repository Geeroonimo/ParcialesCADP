program bizzarap;
const
maxgeneros = 5;
type 
rango_generos= 1..maxgeneros;   //La informacion no posee un orden especifico

sesion = record
 titulo : string;
 artista: string;
 genero: rango_generos;
 estreno: integer;
 reproducciones : integer;
end;

vector_generos= array[rango_generos] of integer;

lista = ^nodo;
nodo = record
 dato: sesion;
 sig: lista;
end;

procedure cargarLista(var L: lista); //SE DISPONE

procedure cargarVector(var VG: vector_generos);
var 
 i: rango_generos;
begin
 for i:= 1 to maxgeneros do
   VG[i]:= 0;
end;

procedure actualizarMinimos(VG: vector_generos; cant_reprod: integer; var cod1,cod2 : integer);
var
 i: rango_generos;
 min1,min2 : integer;
begin
 min1:= 9999;
  for i:= 1 to maxgeneros do begin
    if(VG[i] < min1) then begin
      min2:= min1;
      cod2:= cod1;
      min1:= VG[i];
      cod1:= i;  
    end   
      else
        if(VG[i] < min2) then begin
          min2:= VG[i];
          cod2:= i;
        end;
  end;

end;

function descomponer( reproducciones : integer) : boolean;
var 
 suma: integer;
 dig: integer;
begin
 suma:= 0;
 while(reproducciones <> 0) do begin
   dig:= reproducciones MOD 10;
   suma:= suma + dig;
   reproducciones:= reproducciones DIV 10;
 end;
 descomponer:= (suma MOD 5 = 0)
end;

procedure agregarOrdenado(var L2: lista; s : sesion);
var
 nue: lista;
 act,ant: lista; {Punteros auxiliares para el recorrido}
begin
 new(nue);
 nue^.dato:= s;
 act:= L;
 ant:= L;
 while( act <> nil) and(s.estreno < act^.dato.estreno) do
 begin
  ant:= act; {ubico act y ant al inicio de la lista}
  act:= act^.sig;
 end;
 if(act = ant) then {al inicio o lista vacia}
  L:= nue;
 else {al medio o al final}
  ant^.sig:= nue;
 nue^.sig:= act;
end;


procedure procesarSesiones(L1: lista; var L2: lista; VG: vector_generos);
var
 genero: rango_generos;
 cod1,cod2: integer;
begin
 while(L <> nil) do begin
   genero:= L^.dato.genero;
   VG[genero]:= VG[genero] + L^.dato.reproducciones;
   actualizarMinimos(VG[genero],L^.dato.reproducciones,cod1,cod2);
   writeln('Los dos codigos con menor cantidad de reproducciones en Spotify son: ',cod1,' y',cod2);
   if( genero = 1 and genero = 3) and(descomponer(L^.dato.reproducciones)) then begin
     agregarOrdenado(L2,L1^.dato);
   L1:= L1^.sig; 
   end;
 end;
end;

procedure recorrer_informarL2(L2: lista);
var
 cant_Sesiones, totalRepro : integer;
 anoActual: integer;
begin 
  while(L2 <> nil) do begin
   anoActual:= L2^.dato.estreno
   cant_Sesiones:= 0;
   totalRepro:= 0;
   while(L2 <> nil) and(L2^.dato.estreno = anoActual) do begin
     cant_Sesiones:= cant_Sesiones + 1;
     totalRepro:= totalRepro + L2^.dato.reproducciones;
     L2:= L2^.sig;
   end;
  end;
  writeln('Para el ano',anoActual,'hubo un total de: ', cant_Sesiones,' sesiones y: ',totalRepro,' reproducciones');
end;

var
 L1,L2 : lista;
 V : vector_generos;
BEGIN 
 cargarLista(L); //SE DISPONE
 cargarVector(V);
 procesarSesiones(L,L2,V); //PUNTO A Y B
 recorrer_informarL2(L2); //PUNTO C
END.