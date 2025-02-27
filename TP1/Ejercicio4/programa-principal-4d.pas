{d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
que no tengan cargado el DNI (DNI en 00).}
program cuatrod;

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
	noDNI: text;
	E: empleados;
	eO: empleado;

begin
	assign(E, 'empleados.dat');
	assign(noDNI, 'faltaDNIEmpleado.txt');
	reset(E);
	rewrite(noDNI);
	while (not EOF(E)) do
	begin
		Read(E, eO);
		if(eO.DNI = 00) then
		begin
			with eO do
			begin
				writeln(noDNI, ' ', numEmpleado, ' ', apellido, ' ', nombre, ' ', edad, ' ', DNI);
			end;
		end;
	end;
	close(noDNI);
	close(E);
end.
