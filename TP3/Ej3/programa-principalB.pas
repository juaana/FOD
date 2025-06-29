{
   Abrir el archivo existente y permitir su mantenimiento teniendo en
   cuenta el inciso a), se utiliza lista invertida para recuperación de 
   espacio. En particular, para el campo de “enlace” de la lista (utilice 
   el código de novela como enlace), se debe especificar los números de 
   registro referenciados con signo negativo, . Una vez abierto el archivo, 
   brindar operaciones para:
i. Dar de alta una novela leyendo la información desde teclado. Para esta 
operación, en caso de ser posible, deberá recuperarse el espacio libre. 
Es decir, si en el campo correspondiente al código de novela del registro 
cabecera hay un valor negativo, por ejemplo -5, se debe leer el registro 
en la posición 5, copiarlo en la posición 0 (actualizar la lista de espacio 
libre) y grabar el nuevo registro en la posición 5. Con el valor 0 (cero) 
en el registro cabecera se indica que no hay espacio libre.
ii. Modificar los datos de una novela leyendo la información desde 
teclado. El código de novela no puede ser modificado.
iii. Eliminar una novela cuyo código es ingresado por teclado. Por ejemplo, 
si se da de baja un registro en la posición 8, en el campo código de 
novela del registro cabecera deberá figurar -8, y en el registro en la 
posición 8 debe copiarse el antiguo registro cabecera.

 c. Listar en un archivo de texto todas las novelas, incluyendo las 
 borradas, que representan la lista de espacio libre. El archivo debe
 llamarse “novelas.txt”.
   
}


program TP3EJ3B;

type 

	novela = record
		codigo: integer;
		genero: String[10];
		nombre: String[10];
		duracion: real;
		director: String[10];
		precio: real;
	end;
	
	archivoNovelas = file of novela;
	
procedure altaNovela(var A: archivoNovelas);
var
  nueva, cabecera, libreReg: Novela;
  librePos: integer;
begin
  reset(A);
  // Leer cabecera (posición 0)
  seek(A, 0);
  read(A, cabecera);

  // Leer datos de la nueva novela desde teclado
    writeln('Ingrese código:'); readln(nueva.codigo);
    writeln('Ingrese nombre:'); readln(nueva.nombre);
    writeln('Ingrese género:'); readln(nueva.genero);
    writeln('Ingrese duración:'); readln(nueva.duracion);
    writeln('Ingrese director:'); readln(nueva.director);
    writeln('Ingrese precio:'); readln(nueva.precio);  

  if cabecera.codigo < 0 then
  begin
    librePos := cabecera.codigo * -1;
    // Ir al registro libre
    seek(A, librePos);
    read(A, libreReg);

    // Actualizar cabecera con el siguiente espacio libre
    seek(A, 0);
    cabecera.codigo := libreReg.codigo; // Puede ser 0 o -X
    write(A, cabecera);

    // Guardar la nueva novela en la posición libre
    seek(A, librePos);
    write(A, nueva);
  end
  else
  begin
    // No hay espacio libre, agregar al final
    seek(A, FileSize(A));
    write(A, nueva);
  end;
  close(A);

end;
procedure modificarNovela(var A: archivoNovelas);
var
  regA: novela;
  cod: integer;
  encontrado: boolean;
begin
  reset(A);
  writeln('Ingrese código a buscar:');
  readln(cod);
  encontrado := false;

  while (not EOF(A)) and (not encontrado) do
  begin
    read(A, regA);
    if regA.codigo = cod then
      encontrado := true;
  end;

  if encontrado then
  begin
    // Volver una posición atrás
    seek(A, filePos(A) - 1);

    // Leer nuevos datos (menos el código)
    writeln('Ingrese el nuevo nombre:'); readln(regA.nombre);
    writeln('Ingrese el nuevo género:'); readln(regA.genero);
    writeln('Ingrese la nueva duración:'); readln(regA.duracion);
    writeln('Ingrese el nuevo director:'); readln(regA.director);
    writeln('Ingrese el nuevo precio:'); readln(regA.precio);

    // Escribir el registro modificado
    write(A, regA);
  end
  else
    writeln('Novela no encontrada.');

  close(A);
end;
procedure eliminarNovela(var A: archivoNovelas);
var
  reg, cabecera: novela;
  codigoE: integer;
  pos: integer;
  encontrado: boolean;
begin
  reset(A);
  writeln('Ingrese el código de la novela a eliminar:');
  readln(codigoE);

  encontrado := false;

  // Leer cabecera
  seek(A, 0);
  read(A, cabecera);

  // Buscar la novela a eliminar (empezamos en 1 para no tocar la cabecera)
  while (not EOF(A)) and (not encontrado) do
  begin
    pos := filePos(A); // Guardamos la posición actual
    read(A, reg);
    if reg.codigo = codigoE then
      encontrado := true;
  end;

  if encontrado then
  begin
    // Enlazar el eliminado a la lista de libres
    reg.codigo := cabecera.codigo; // por ejemplo, -3 o 0 si no había libre

    // Grabarlo en su posición
    seek(A, pos);
    write(A, reg);

    // Actualizar cabecera para que apunte a este nuevo libre
    cabecera.codigo := -pos;
    seek(A, 0);
    write(A, cabecera);

    writeln('Novela eliminada correctamente.');
  end
  else
    writeln('Código no encontrado.');

  close(A);
end;
procedure exportarNovelas(var A: archivoNovelas; var AE: text);
var 
	regA: novela;
begin
	reset(A);
	rewrite(AE);
	read(A, regA);
	while (NOT(EOF(A))) do
	begin
		writeln(AE, regA.nombre);
		writeln(AE,regA.genero );
		writeln(AE, regA.duracion);
		writeln(AE, regA.director);
		writeln(AE,regA.precio);
		read(A, regA);
	end;
	close(A);
	close(AE);
	Writeln('Archivo exportado con éxito');
end;

procedure menu(var A: archivoNovelas; var AE: text);
var
	i: integer;
begin
	i:=0;
	while (i <> 5) do 
	begin
		Writeln('Seleccione:');
		Writeln('1 para dar de alta una novela');
		Writeln('2 para modificar una novela');
		Writeln('3 para eliminar una novela');
		Writeln('4 para exportar');
		Writeln('5 para finalizar');
		readln(i);
		case i of 
		1: altaNovela(A);
		2: modificarNovela(A);
		3: eliminarNovela(A);
		4: exportarNovelas(A, AE);
		5: Writeln('Programa finalizado');
		else
		Writeln('Opcion inválida');
		end;
	end;
end;
var
	A: archivoNovelas;
	AE: text;
	arch: String;
BEGIN
	Writeln('Ingrese el nombre del archivo a crear');
	readln(arch);
	Assign(A, arch + '.dat');
	Assign(AE, 'novelas.txt');
	menu(A, AE);
END.

