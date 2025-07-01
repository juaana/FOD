program TP3EJ8;
const 
  VA = '9999';
type
  nombreCorto = String[10];
  
  dLinux = record
    nombre: nombreCorto;
    anoLanz: integer;
    numVersion: integer;
    cantDesa: integer;  // Para lista invertida: <0 indica posición libre
    descripcion: String[20];
  end;

  aDLinux = file of dLinux;

procedure leer(var A: aDLinux; var dato: dLinux);
begin
  if (NOT (EOF(A))) then
    read(A, dato)
  else
    dato.nombre := VA;
end;

function buscarDistribucion(var A: aDLinux; nombre: nombreCorto): integer;
var
  regA: dLinux;
  pos: integer;
  encontrado: boolean;
begin
  
  encontrado := false;
  pos := -1;
  
  leer(A, regA);
  while (regA.nombre <> VA) AND (NOT (encontrado)) do
  begin
    if regA.nombre = nombre then
    begin
      encontrado := true;
      pos := FilePos(A) - 1;
    end
    else
      leer(A, regA);
  end;
  
  if encontrado then
    buscarDistribucion := pos
  else
    buscarDistribucion := -1;
end;

procedure AltaDistribucion(var A: aDLinux; regA: dLinux);
var
  cabecera, actual: dLinux;
begin
  reset(A);
 
  if buscarDistribucion(A, regA.nombre) <> -1 then
  begin
    writeln('Esta distribución ya existe');
  end
  else
  begin
    seek(A, 0);
    leer(A, cabecera);
    if cabecera.cantDesa < 0 then
    begin
      seek(A, (-cabecera.cantDesa));  // posición libre para reutilizar
      leer(A, actual);
      cabecera.cantDesa := actual.cantDesa; // actualizar cabecera con siguiente libre
      seek(A, FilePos(A) - 1);
      write(A, regA);
      seek(A, 0);
      write(A, cabecera);
    end
    else
    begin
      seek(A, FileSize(A)); // agregar al final
      write(A, regA);
    end;
  end;
  close(A);
end;

procedure BajaDistribucion(var A: aDLinux; n: nombreCorto);
var
  cabecera, actual: dLinux;
  pos: integer;
begin
  reset(A);
  pos := buscarDistribucion(A, n);
  if pos = -1 then
  begin
    writeln('Distribución no existente');
  end
  else
  begin
    seek(A, 0);
    leer(A, cabecera);

    seek(A, pos);
    leer(A, actual);

    // Enlazar en lista invertida: cantDesa apunta a la cabecera
    actual.cantDesa := cabecera.cantDesa;
    seek(A, pos);
    write(A, actual);

    // Actualizar cabecera con nuevo espacio libre
    cabecera.cantDesa := pos * -1;
    seek(A, 0);
    write(A, cabecera);

    writeln('Distribución dada de baja correctamente');
  end;
  close(A);
end;

procedure menu(var A: aDLinux);
var
  i: integer;
  n: nombreCorto;
  regA: dLinux;
begin
  i := 0;
  while i <> 3 do
  begin
    writeln('Seleccione:');
    writeln('1 para dar de alta una distribución');
    writeln('2 para dar de baja una distribución');
    writeln('3 para finalizar');
    readln(i);
    case i of
      1: begin
        writeln('Ingrese el nombre de la distribución: ');
        readln(regA.nombre);
        writeln('Ingrese el año de lanzamiento: ');
        readln(regA.anoLanz);
        writeln('Ingrese el número de versión del kernel: ');
        readln(regA.numVersion);
        writeln('Ingrese la cantidad de desarrolladores: ');
        readln(regA.cantDesa);
        writeln('Ingrese la descripción: ');
        readln(regA.descripcion);
        AltaDistribucion(A, regA);
      end;
      2: begin
        writeln('Ingrese el nombre de la distribución a dar de baja: ');
        readln(n);
        BajaDistribucion(A, n);
      end;
      3: writeln('Programa finalizado');
    else
      writeln('Opción inválida, intente de nuevo.');
    end;
    writeln;
  end;
end;

var
  A: aDLinux;
  regA: dLinux;

begin
  Assign(A, 'distribuciones.dat');
  menu(A);
end.
