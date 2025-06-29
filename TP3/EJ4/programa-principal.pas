{
El programa toma como precondicion que se creo el archivo con 0 en el primer registro asumiendo q no hay bajas
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
procedure menu(var A: tArchFlores);
var 
	i,codigo: integer;
	nombre: String;
begin
	i:=0;
	while (i<> 3) do
	begin
		writeln('Seleccione:');
		writeln('1 para agregar una flor');
		writeln('2 para listar las flores');
		writeln('3 para finalizar');
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
			3: writeln('Programa finalizado');
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

