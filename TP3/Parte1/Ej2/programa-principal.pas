{
   2. Definir un programa que genere un archivo con registros de longitud
   fija conteniendo información de asistentes a un congreso a partir de 
   la información obtenida por teclado.
   
   Se deberá almacenar la siguiente información: 
   -nro de asistente, 
   -apellido y 
   -nombre, 
   -email, 
   -teléfono y 
   -D.N.I. 
   Implementar un procedimiento que, a partir del archivo de datos generado, 
   elimine de forma lógica todos los asistentes con nro de asistente inferior a 1000.
	Para ello se podrá utilizar algún carácter especial situándolo delante 
	de algún campo String a su elección. Ejemplo: ‘@Saldaño’.
   
}


program TP3EJ2;
type
	asistente = record
		nro: integer;
		apellido: String[10];
		nombre: String[10];
		email: String[20];
		telefono: integer;
		DNI: integer;
	end;

	asistentes = file of asistente;
	
procedure cargarAsistentes(var A: asistentes);
var
	regA: asistente;
	nro: integer;
begin
	reset(A);
	Writeln('Ingrese el numero de asistente o 0 para finalizar la carga');
	Readln(nro);
	while (nro > 0 ) do 
	begin
		regA.nro:= nro;
		Writeln('Ingrese el apellido del asistente');
		Readln(regA.apellido);
		Writeln('Ingrese el nombre del asistente');
		Readln(regA.nombre);
		Writeln('Ingrese el email del asistente');
		Readln(regA.email);
		Writeln('Ingrese el telefono del asistente');
		Readln(regA.telefono);
		Writeln('Ingrese el DNI del asistente');
		Readln(regA.DNI);
		Write(A, regA);
	
		Writeln('Ingrese el numero de asistente o 0 para finalizar la carga');
		Readln(nro);
	end;
	
	close(A);
	writeln('Carga finalizada con éxito');
end;

procedure bajaAsistentes(var A: asistentes);
var
	regA: asistente;
begin
	reset(A);
	while (NOT(EOF(A))) do
	begin
		read(A, regA);
		if (regA.nro < 1000) then
		begin
			regA.apellido:= '@' + regA.apellido;
			seek(A, filePos(A) -1);
			write(A, regA);
		end;
	end;
	close(A);
end;

var
	A: asistentes;
	regA: asistente;
BEGIN
	Assign(A, 'asistentes.dat');
	cargarAsistentes(A);
	bajaAsistentes(A);
	
	reset(A);
	while(NOT(EOF(A))) do
	begin
		Read(A, regA);
		Writeln('Numero ', regA.nro, '. Apellido ', regA.apellido);
	end;
	close(A);
END.

