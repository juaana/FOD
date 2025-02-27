{
   3. a. Crear un archivo de registros no ordenados de empleados y completarlo con
datos ingresados desde teclado. De cada empleado se registra: número de
empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
   
   
}


program tresA;

type
	empleado = record
		numEmpleado: integer;
		apellido: String;
		nombre: String; 
		edad: integer;
		DNI: integer;
	end;
	
	empleados= file of empleado;
	
var
	E: empleados;
	eO: empleado;
	nomArch: String;
BEGIN
	Writeln('Ingrese el nombre del archivo');
	Readln(nomArch);
	assign(E , nomArch + '.dat');
	rewrite(E);
	with eO do
	begin
		Writeln('Ingrese el numero de empleado');
		Readln(numEmpleado);
		Writeln('Ingrese el apellido del empleado');
		Readln(apellido);
		while (apellido <> 'fin') do 
		begin
			Writeln('Ingrese el nombre del empleado');
			Readln(nombre);
			Writeln('Ingrese la edad del empleado');
			Readln(edad);
			Writeln('Ingrese el DNI del empleado');
			Readln(DNI);
			write(E, eO);
			Writeln('Ingrese el numero de empleado');
			Readln(numEmpleado);
			Writeln('Ingrese el apellido del empleado');
			Readln(apellido);
		end;				
	end;
	close(E);
	
END.

