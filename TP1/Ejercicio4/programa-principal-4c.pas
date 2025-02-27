{Exportar el contenido del archivo a un archivo de texto llamado
todos_empleados.txt.}
program cuatroc;

type
	empleado = record
		numEmpleado: integer;
		apellido: String;
		nombre: String; 
		edad: integer;
		DNI: integer;
	end;
	
	empleados = file of empleado;

var
	ET: text;
	E: empleados;
	eO: empleado;

begin
	assign(E, 'empleados.dat');
	assign(ET, 'todos_empleados.txt');
	reset(E);
	rewrite(ET);
	while (not EOF(E)) do
	begin
		Read(E, eO);
		with eO do
		begin
			writeln(ET, ' ', numEmpleado, ' ', apellido, ' ', nombre, ' ', edad, ' ', DNI);
		end;
	end;
	close(ET);
	close(E);
end.
