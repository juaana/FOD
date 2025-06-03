{
  Una compañía aérea dispone de un archivo maestro donde guarda información
  sobre sus próximos vuelos. En dicho archivo se tiene almacenado el 
  
  destino, fecha, hora de salida y la cantidad de asientos disponibles. 
  
  La empresa recibe todos los días dos archivos detalles para actualizar 
  el archivo maestro. 
  
  En dichos archivos se tiene destino, fecha, hora de salida y cantidad de asientos comprados.
  
  Se sabe que los archivos están ordenados por destino más fecha y hora de salida,
  y que en los detalles pueden venir 0, 1 ó más registros por cada uno del maestro. Se pide realizar los módulos necesarios para:
b. Generar una lista con aquellos vuelos (destino y fecha y hora de salida) que tengan menos de una cantidad específica de asientos disponibles. 
La misma debe ser ingresada por teclado.   
}


program EJ14TP2;
const valorAlto= 'ZZZ';

type 
	vuelo = record
		destino: String[10];
		fecha: integer;
		hora:integer;
		cantidadAsientos: integer;
	end;
	
	arch= file of vuelo;

procedure leer ( var archivo: arch; var data: vuelo);
begin
	if(NOT(EOF(archivo))) then
		read(archivo,data)
	else
		data.destino:= valorAlto;
end;

procedure imprimir(var maestro: arch);
var
regM: vuelo;
asientos: integer;
begin
	Writeln('Ingrese la cantidad minima de asientos disponibles');
	Readln(asientos);
	Reset(maestro);
	leer(maestro, regM);
	
	while(regM.destino<> valorAlto) do
	begin
		if (regM.cantidadAsientos < asientos) then
		begin
			 writeln('Destino: ', regM.destino, ', Fecha: ', regM.fecha, ', Hora: ', regM.hora, ', Asientos: ', regM.cantidadAsientos);
		end;
		leer(maestro, regM);
	end;
	
	close(maestro);

end;


var
 maestro: arch;
 
BEGIN
	assign(maestro, 'maestro.dat');
	imprimir(maestro);

END.
