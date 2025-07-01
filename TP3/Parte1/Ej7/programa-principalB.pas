{
   7. Se cuenta con un archivo que almacena información sobre especies 
   de aves en vía de extinción, para ello se almacena: código, nombre de 
   la especie, familia de ave, descripción y zona geográfica. El archivo 
   no está ordenado por ningún criterio. Realice un programa que permita 
   borrar especies de aves extintas. Este programa debe disponer de dos 
   procedimientos
   a. Un procedimiento que dada una especie de ave (su código) marque la 
   misma como borrada (en caso de querer borrar múltiples especies de aves, 
   se podría invocar este procedimiento repetidamente).
   i. Implemente una variante de este procedimiento de compactación del 
   archivo (baja física) donde el archivo se trunque una sola vez.
   
}
program TP3EJ7;
const
	VA= 9999;
type
	
	ave = record
		codigo: integer;
		nombreEspecie: String[20];
		familia: String[20];
		descripcion: String[40];
		zonaGeografica: String[20];
		end;
	aves = file of ave;
procedure listarAves(var A: aves);
var
	regA: ave;
begin
	reset(A);
	while(NOT(EOF(A))) do
	begin
		read(A, regA);
		Writeln('Código: ', regA.codigo);
		Writeln('Nombre especie: ', regA.nombreEspecie);
		Writeln('Familia: ', regA.familia);
		Writeln('Descripción: ', regA.descripcion);
		Writeln('Zona geográfica: ', regA.zonaGeografica);
		
	end;

	close(A);
end;
procedure leer(var A: aves ; var regA: ave);	
begin
	if (NOT(EOF(A))) then
		read(A, regA)
	else
		regA.codigo:= VA;
end;
procedure eliminarAve(var A: aves);
var
  regA: ave;
  cod: integer;
  encontrado: boolean;
begin
  reset(A);
  encontrado := false;
  writeln('Escriba el código del ave a eliminar:');
  readln(cod);
  leer(A, regA);
  while (regA.codigo <> VA) and (not encontrado) do
  begin
    if regA.codigo = cod then
    begin
      regA.codigo := -cod; // marcamos como borrado
      seek(A, FilePos(A) -1);        // volvemos a la posición actual
      write(A, regA);      // escribimos el registro actualizado
      encontrado := true;
    end;
    leer(A, regA);
  end;

  if encontrado then
    writeln('Ave marcada como borrada.')
  else
    writeln('Ave no encontrada.');

  close(A);
end;

procedure eliminarAveDefinitiva(var A: aves);
var
  actual, reemplazo: ave;
  posActual, posReemp: integer;
begin
  reset(A);
  posReemp := FileSize(A) - 1;

  leer(A, actual);
  while (actual.codigo <> VA) and (FilePos(A) - 1 <= posReemp) do
  begin
    if (actual.codigo < 0) and (FilePos(A) - 1 < posReemp) then
    begin
      posActual := FilePos(A) - 1;

      // Buscar desde el final un reemplazo válido
      seek(A, posReemp);
      leer(A, reemplazo);
      while (reemplazo.codigo < 0) and (posReemp > posActual) do
      begin
        posReemp := posReemp - 1;
        seek(A, posReemp);
        leer(A, reemplazo);
      end;

      // Si hay reemplazo válido distinto de la posición actual
      if (reemplazo.codigo > 0) and (posReemp > posActual) then
      begin
        seek(A, posActual);
        write(A, reemplazo);

        seek(A, posReemp);
        write(A, actual);

        posReemp := posReemp - 1;
      end;
    end;

    leer(A, actual); // avanzar siempre
  end;

  // Ahora sí: truncar desde el primer código negativo (o final si ninguno)
  seek(A, 0);
  leer(A, actual);
  while (actual.codigo > 0) and (actual.codigo <> VA) do
  begin
    leer(A, actual);
  end;

  // Si hay algún código negativo, lo truncamos
  if (actual.codigo < 0) then
  begin
    seek(A, FilePos(A) - 1);
    truncate(A);
  end
  else
  begin
    // Si no se encontró ningún borrado, no se trunca
    seek(A, FileSize(A));
  end;

  close(A);
end;




procedure menu(var A: aves);
var
	i: integer;
begin
	i:=0;
	while(i<>3) do
	begin
		Writeln('Seleccione:');
		Writeln('1 para eliminar un ave');
		Writeln('2 para eliminar definitivamente las aves');
		Writeln('3 para finalizar');
		readln(i);
		
		case i of
		1: eliminarAve(A);
		2: eliminarAveDefinitiva(A);
		3: Writeln('Programa finalizado');
	end;
	end;
end;
procedure crearArchivo(var A: aves);
var
  regA: ave;
begin
  rewrite(A); // crea o sobreescribe el archivo

  regA.codigo := 1;
  regA.nombreEspecie := 'Cóndor Andino';
  regA.familia := 'Cathartidae';
  regA.descripcion := 'Ave carroñera de gran envergadura';
  regA.zonaGeografica := 'Andes';
  write(A, regA);

  regA.codigo := 2;
  regA.nombreEspecie := 'Macá Tobiano';
  regA.familia := 'Podicipedidae';
  regA.descripcion := 'Endémica de Santa Cruz';
  regA.zonaGeografica := 'Patagonia';
  write(A, regA);

  regA.codigo := 3;
  regA.nombreEspecie := 'Águila Arpía';
  regA.familia := 'Accipitridae';
  regA.descripcion := 'Ave rapaz más poderosa del mundo';
  regA.zonaGeografica := 'Amazonas';
  write(A, regA);

  regA.codigo := 4;
  regA.nombreEspecie := 'Chorlito Pampero';
  regA.familia := 'Charadriidae';
  regA.descripcion := 'Ave migratoria de pastizales';
  regA.zonaGeografica := 'Pampa';
  write(A, regA);

  regA.codigo := 5;
  regA.nombreEspecie := 'Ñandú Petiso';
  regA.familia := 'Rheidae';
  regA.descripcion := 'Ave no voladora del sur argentino';
  regA.zonaGeografica := 'Patagonia';
  write(A, regA);

  close(A);
  writeln('Archivo aves.dat creado con datos de ejemplo.');
end;


var
	A: aves;
	
BEGIN
	Assign(A, 'aves.dat');
	crearArchivo(A);
	listarAves(A);
	menu(A);
	listarAves(A);
END.

