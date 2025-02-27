{Añadir uno o más empleados al final del archivo con sus datos ingresados por
teclado. Tener en cuenta que no se debe agregar al archivo un empleado con
un número de empleado ya registrado (control de unicidad).}
program cuatroa;

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

procedure buscarPorNombre(var E: empleados);
var
	eO: empleado;
	dato: String;
begin
	Writeln('Ingrese el nombre del empleado a buscar');
	Readln(dato);
	while (not EOF(E)) do
	begin 
		Read(E, eO);
		if(dato = eO.nombre) then
			begin
				imprimirEmpleado(eO);
			end;
		
	end
end;

procedure buscarPorApellido(var E: empleados);
var
	eO: empleado;
	dato: String;
begin
	Writeln('Ingrese el apellido del empleado a buscar');
	Readln(dato);
	while (not EOF(E)) do
	
	begin 
		Read(E, eO);
		if(dato = eO.apellido) then
			begin
				imprimirEmpleado(eO);
			end;
		
	end
end;

procedure buscarPorNumero(var E: empleados; var esta: boolean; var dato: integer);
var
	eO: empleado;
begin
	
	while (not EOF(E)) do
	begin
		Read(E, eO);
		if (eO.numEmpleado = dato) then
		begin
			esta := true;
		end;
	end;
end;

procedure agregarEmpleado(var E: empleados);
var
	dato: integer;
	esta: boolean;
	eO: empleado;
begin
	esta:= false;
	Writeln('Ingrese el número de empleado del nuevo empleado');
	Readln(dato);
	buscarPorNumero(E, esta, dato);
	
	if (esta = true) then
	begin
		Writeln('El usuario ya se encuentra registrado');
	end
	else
		begin
			with eO do
			begin
				numEmpleado := dato;
				Writeln('Ingrese el apellido del empleado');
				Readln(apellido);
				Writeln('Ingrese el nombre del empleado');
				Readln(nombre);
				Writeln('Ingrese la edad del empleado');
				Readln(edad);
				Writeln('Ingrese el DNI del empleado');
				Readln(DNI);
			end;
		Write(E, eO);
		Writeln('Usuario agregado correctamente');
		end;
end;

procedure menu(var E: empleados);
var
	opcion: integer;
begin
	opcion:= 0;
	while (opcion <> 6) do
	begin
		Writeln('Seleccione una opción:');
		Writeln('1 - Buscar empleado por nombre');
		Writeln('2 - Buscar empleado por apellido');
		Writeln('3 - Listar todos los empleados');
		Writeln('4 - Listar empleados próximos a jubilarse');
		Writeln('5 - Agregar un nuevo empleado');
		Writeln('6 - FINALIZAR');
		Readln(opcion);

		case opcion of
			1: buscarPorNombre(E);
			2: buscarPorApellido(E);
			3: listarEmpleados(E);
			4: listarProximosJubilacion(E);
			5: agregarEmpleado(E);
			6: Writeln('Programa finalizado');
		else
			Writeln('Opción no válida.');
		end;
	end;
end;
var
	E: empleados;
	nomArch: String;
BEGIN
	Writeln('Ingrese el nombre del archivo a leer');
	Readln(nomArch);
	assign(E, nomArch + '.dat');
	reset(E);
	menu(E);
	close(E);
END.
