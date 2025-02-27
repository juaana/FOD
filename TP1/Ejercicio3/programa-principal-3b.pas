program tresb;

type
	empleado = record
		numEmpleado: integer;
		apellido: String;
		nombre: String; 
		edad: integer;
		DNI: integer;
	end;
	
	empleados = file of empleado;

procedure imprimirEmpleado(eO: empleado);
begin
	with eO do
	begin
		writeln('Empleado número: ', numEmpleado);
		writeln('Nombre: ', nombre, ' ', apellido);
		writeln('Edad: ', edad, ' - DNI: ', DNI);
		writeln('--------------------------------------');
	end;
end;

procedure seleccionarBusqueda(var E: empleados; opcion: integer);
var
	busqueda: string;
	eO: empleado;
begin
	if (opcion = 1) then
	begin
		Writeln('Ingrese el nombre del empleado a buscar:');
		Readln(busqueda);
	end
	else 
	begin
		Writeln('Ingrese el apellido del empleado a buscar:');
		Readln(busqueda);
	end;

	while (not EOF(E)) do
	begin
		Read(E, eO);
		if ((opcion = 1) and (eO.nombre = busqueda)) or 
		   ((opcion = 2) and (eO.apellido = busqueda)) then
		begin
			imprimirEmpleado(eO);
		end;
	end;
end;

procedure listarEmpleados(var E: empleados);
var
	eO: empleado;
begin
	while (not EOF(E)) do
	begin
		Read(E, eO);
		imprimirEmpleado(eO);
	end;
end;

procedure listarProximosJubilacion(var E: empleados);
var
	eO: empleado;
begin
	while (not EOF(E)) do
	begin
		Read(E, eO);
		if (eO.edad > 70) then
			imprimirEmpleado(eO);
	end;
end;

var
	E: empleados;
	opcion: integer;
	nomArch: String;
BEGIN
	Writeln('Ingrese el nombre del archivo a leer');
	Readln(nomArch);
	assign(E, nomArch + '.dat');
	reset(E);

	Writeln('Seleccione una opción:');
	Writeln('1 - Buscar empleado por nombre');
	Writeln('2 - Buscar empleado por apellido');
	Writeln('3 - Listar todos los empleados');
	Writeln('4 - Listar empleados próximos a jubilarse');
	Readln(opcion);

	case opcion of
		1, 2: seleccionarBusqueda(E, opcion);
		3: listarEmpleados(E);
		4: listarProximosJubilacion(E);
	else
		Writeln('Opción no válida.');
	end;

	close(E);
END.
