{
Dada la estructura planteada en el ejercicio anterior, implemente el siguiente módulo:
Abre el archivo y elimina la flor recibida como parámetro manteniendo la política descripta anteriormente

}


program untitled;
type
	reg_flor = record
		nombre: String[45];
		codigo: integer;
	end;
	
	tArchFlores = file of reg_flor;
	
procedure agregarFlor (var a: tArchFlores ; nombre: string; codigo:integer);
var
	cabecera, regF, libre: reg_flor;
	pos: integer;
begin
	reset(a);
	seek(a, 0);
	read(a, cabecera);
	regF.nombre:= nombre;
	regF.codigo:= codigo;
	if (cabecera.codigo < 0) AND (NOT(EOF(a))) then
	begin
		pos:= cabecera.codigo * -1;
		
		seek(a, pos);
		read(a, libre);
		seek(a, filePos(a)-1);
		
		write(a, regF);
		
		seek(A, 0);
		cabecera.codigo := libre.codigo;
		write(a, cabecera);
	end
	else
		begin
			seek(a, FileSize(a));
			write(a, regF);
		end;
	close(a);
end;

procedure listarFlores(var a: tArchFlores);
var
	regF: reg_flor;
begin
	reset(a);
	read(a, regF);
	while (NOT(EOF(a))) do
	begin
		if(regF.codigo > 0) then
		begin
			Writeln('Flor: ');
			Writeln('Nombre: ', regF.nombre);
			Writeln('Código: ', regF.codigo);
		end;
		read(a, regF);
	end;
	close(a);
end;
procedure eliminarFlor (var a: tArchFlores; flor:reg_flor);
var
	encontrado: boolean;
	actual, cabecera: reg_flor;
	pos: integer;
begin
	reset(a);
	seek(a, 0);
	read(a, cabecera);
	encontrado:= false;
	while  (not(EOF(a))) AND (not(encontrado)) do
	begin
		pos:= filePos(a);
		read(a, actual);
		if (actual.codigo = flor.codigo) AND (actual.nombre = flor.nombre) then
		encontrado := true;
	end;
	
	if(encontrado) then
	begin
		actual.codigo:= cabecera.codigo;
		seek(a, pos);
		write(a, actual);
		
		cabecera.codigo:= -pos;
		seek(a,0);
		write(a, cabecera);
		Writeln('Flor eliminada con éxito');
	end
	else
		begin
			Writeln('Flor no encontrada');
		end;
	close(a);
end;
procedure menu(var A: tArchFlores);
var 
	i,codigo: integer;
	nombre: String;
	regF: reg_flor;
begin
	i:=0;
	while (i<> 4) do
	begin
		writeln('Seleccione:');
		writeln('1 para agregar una flor');
		writeln('2 para listar las flores');
		writeln('3 para eliminar una flor');
		writeln('4 para finalizar');
		readln(i);
			case i of 
			1: begin
				writeln('Ingrese un nombre de flor'); 
				readln(nombre);
				writeln('Ingrese el código de la flor'); 
				readln(codigo);
				agregarFlor(A, nombre, codigo);
			end;
			2: listarFlores(A);
			3: begin
				Writeln('Ingrese el nombre de la flor a eliminar');
				Readln(regF.nombre);
				Writeln('Ingrese el código de la flor a eliminar');
				Readln(regF.codigo);
				eliminarFlor(a, regF);
			end;
			4: writeln('Programa finalizado');
		else
			writeln('Opción inválida');
		end;

	end;
	
end;
var
A: tArchFlores;
BEGIN
	Assign(A, 'flores.dat');
	menu(A);
END.

