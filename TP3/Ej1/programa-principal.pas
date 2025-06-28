{
   1. Modificar el ejercicio 4 de la práctica 1 (programa de gestión de 
   empleados), agregándole una opción para realizar bajas copiando el 
   último registro del archivo en la posición del registro a borrar y 
   luego truncando el archivo en la posición del último registro de 
   forma tal de evitar duplicados.
   
   
}


program TP3EJ1;

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
	reset(E);
	while (not EOF(E)) do
	begin
		Read(E, eO);
		imprimirEmpleado(eO);
	end;
	close(E);
end;

procedure listarProximosJubilacion(var E: empleados);
var
	eO: empleado;
begin
	reset(E);
	while (not EOF(E)) do
	begin
		Read(E, eO);
		if (eO.edad > 70) then
			imprimirEmpleado(eO);
	end;
	close(E);
end;

procedure buscarPorNombre(var E: empleados);
var
	eO: empleado;
	dato: String;
begin
	reset(E);
	Writeln('Ingrese el nombre del empleado a buscar');
	Readln(dato);
	while (not EOF(E)) do
	begin 
		Read(E, eO);
		if(dato = eO.nombre) then
			begin
				imprimirEmpleado(eO);
			end;
		
	end;
	close(E);
end;

procedure buscarPorApellido(var E: empleados);
var
	eO: empleado;
	dato: String;
begin
	reset(E);
	Writeln('Ingrese el apellido del empleado a buscar');
	Readln(dato);
	while (not EOF(E)) do
	
	begin 
		Read(E, eO);
		if(dato = eO.apellido) then
			begin
				imprimirEmpleado(eO);
			end;
		
	end;
	close(E);
end;

procedure buscarPorNumero(var E: empleados; var esta: boolean; var dato: integer);
var
	eO: empleado;
begin
	reset(E); 
	while (not EOF(E)) do
	begin
		Read(E, eO);
		if (eO.numEmpleado = dato) then
		begin
			esta := true;
		end;
	end;
	close(E);
end;

procedure agregarEmpleado(var E: empleados);
var
	dato: integer;
	esta: boolean;
	eO: empleado;
begin
	reset(E);
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
	close(E);
end;
procedure bajaEmpleado(var E: empleados);
var
	numEmp, posAEliminar: integer;
	encontrado: boolean;
	emp, ultEmpleado: empleado;
	
begin
	reset(E);
	Writeln('Ingrese el número de empleado a eliminar'); 
	readln(numEmp);
	encontrado:= false;
	
	while (NOT(EOF(E))) AND (NOT (encontrado)) do
	begin
		posAEliminar:= filePos(E);
		read(E, emp);
		if (numEmp = emp.numEmpleado) then
		begin
			encontrado:= true;
		end;
	end;
	if encontrado then
	begin
		seek(E, fileSize(E) -1);
		read(E, ultEmpleado);
		
		seek(E, posAEliminar);
		write(E, ultEmpleado);
		
		seek(E, fileSize(E) -1);
		truncate(E);
		Writeln('Empleado eliminado con éxito');
	end
	else
		begin
			Writeln('Empleado no encontrado');
		end;
	close(E);
	
	
end;
procedure menu(var E: empleados);
var
	opcion: integer;
begin
	opcion:= 0;
	while (opcion <> 7) do
	begin
		Writeln('Seleccione una opción:');
		Writeln('1 - Buscar empleado por nombre');
		Writeln('2 - Buscar empleado por apellido');
		Writeln('3 - Listar todos los empleados');
		Writeln('4 - Listar empleados próximos a jubilarse');
		Writeln('5 - Agregar un nuevo empleado');
		Writeln('6 - Eliminar un empleado');
		Writeln('7 - FINALIZAR');
		Readln(opcion);

		case opcion of
			1: buscarPorNombre(E);
			2: buscarPorApellido(E);
			3: listarEmpleados(E);
			4: listarProximosJubilacion(E);
			5: agregarEmpleado(E);
			6: bajaEmpleado(E);
			7: Writeln('Programa finalizado');
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

	menu(E);

END.

