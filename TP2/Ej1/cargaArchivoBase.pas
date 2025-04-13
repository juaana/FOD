{
  Una empresa posee un archivo con información de los ingresos percibidos por diferentes
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
nombre y monto de la comisión. La información del archivo se encuentra ordenada por
código de empleado y cada empleado puede aparecer más de una vez en el archivo de
comisiones.
Realice un procedimiento que reciba el archivo anteriormente descripto y lo compacte. En
consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
única vez con el valor total de sus comisiones.
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
recorrido una única vez.
   
   
}


program ej1tp2;

type
	empleado = record
		codigo: integer;
		nombre: String[8];
		monto: real;
		end;
	
	aEmpleados= file of empleado;

var
	
	e: empleado;
	cod: integer;
	aE: aEmpleados;

BEGIN
	assign(aE, 'empleados.dat');
	Rewrite(aE);
	
	Writeln('Ingrese el código de empleado');
	Readln(cod);
	while (cod > 0) do
		begin	
			e.codigo:= cod;
			Writeln('Ingrese el nombre de empleado');
			Readln(e.nombre);
			Writeln('Ingrese el monto de comision de empleado');
			Readln(e.monto);
			Write(aE, e);
			Writeln('Ingrese el código de empleado');
			Readln(cod);
		end;	
	close(aE);
	
	Reset(aE);
	
	while (not (eof(aE))) do
	begin
		Read(aE,e);
		Writeln('Nombre del empleado ' , e.nombre);
		Writeln('Código del empleado ' , e.codigo);
		Writeln('Monto del empleado ' , e.monto);
	end;
	
	close(aE);
	
	
	
END.

