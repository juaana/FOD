{
La empresa de software ‘X’ posee un servidor web donde se encuentra 
alojado el sitio web de la organización. En dicho servidor, 
se almacenan en un archivo todos los accesos que se realizan al sitio. 
La información que se almacena en el archivo es la siguiente: 
año, mes, día, idUsuario y tiempo de acceso al sitio de la organización. 
  
El archivo se encuentra ordenado por los siguientes criterios: año, mes, día e idUsuario.
Se debe realizar un procedimiento que genere un informe en pantalla, 
para ello se indicará el año calendario sobre el cual debe realizar el informe. 
	
	
Se deberá tener en cuenta las siguientes aclaraciones:
● El año sobre el cual realizará el informe de accesos debe leerse desde el teclado.
● El año puede no existir en el archivo, en tal caso, debe informarse en pantalla “año no encontrado”.
● Debe definir las estructuras de datos necesarias.
● El recorrido del archivo debe realizarse una única vez procesando sólo la información necesaria.
   
}


program EJ12TP2;

const valor_alto = 9999;

type
	acceso = record
		anio: integer;
		mes: integer;
		dia: integer;
		idUsuario: integer;
		tiempo: real;
	end;
	
	archivoAccesos = file of acceso;

procedure leer(var archivo: archivoAccesos; var dato: acceso);
begin
	if (NOT(EOF(archivo))) then
		read(archivo, dato)
	else 
		dato.anio:= valor_alto;
end;

procedure informe (var archivo: archivoAccesos); 
var
	dato: acceso;
	anio, mes, dia, idUsuario: integer;
	tiempoTotalAnio, tiempoTotalMes, tiempoTotalDia, tiempoTotalUsuario: real;
	existe: boolean;
begin
	existe:= false;
	reset(archivo);
	Writeln('Ingrese el año a informar');
	Readln(anio);
	leer(archivo, dato);
	while(dato.anio <> valor_alto) AND (existe = false) do 
	begin
		if (dato.anio = anio) then
		begin
			existe:= true;
			Writeln('Año: ', anio);
			tiempoTotalAnio:= 0;
			while (dato.anio= anio) do
			begin
				mes:= dato.mes;
				Writeln('Mes: ', mes);
				tiempoTotalMes:= 0;
				while (dato.anio = anio) AND (dato.mes = mes) do
				begin
					dia:= dato.dia;
					Writeln('Día: ', dia);
					tiempoTotalDia:= 0;
					while (dato.anio= anio) AND (dato.mes = mes) AND (dato.dia = dia) do
					begin
						idUsuario:= dato.idUsuario;
						Write('ID Usuario: ', idUsuario);
						tiempoTotalUsuario:= 0;
						while (dato.anio= anio) AND (dato.mes = mes) AND (dato.dia = dia) AND (idUsuario = dato.idUsuario) do
						begin
							tiempoTotalUsuario:= tiempoTotalUsuario + dato.tiempo;
							leer(archivo, dato);
						end;
						Write(': Tiempo total de acceso en el día ', dia, ' mes ', mes, ': ', tiempoTotalUsuario:0:2);
						Writeln;
						tiempoTotalDia:= tiempoTotalDia + tiempoTotalUsuario;
					end;
					Writeln('Tiempo total de acceso en el dia ', dia , ' del mes ', mes ,': ', tiempoTotalDia:0:2);
					tiempoTotalMes:= tiempoTotalMes + tiempoTotalDia;
				end;	
				Writeln('Tiempo total de acceso en mes ', mes ,': ', tiempoTotalMes:0:2);
				tiempoTotalAnio:= tiempoTotalAnio + tiempoTotalMes;	
			end;
			Writeln('Tiempo total de acceso en año ', anio ,': ', tiempoTotalAnio:0:2);			
		end
		else
			begin
				leer(archivo, dato);
			end;
	end;
	
	if (existe = false) then
		Writeln('No se encontraron datos para el año ingresado');
	
	
	
	close(archivo);
end;
var
	archivo: archivoAccesos;
BEGIN
	assign(archivo, 'archivoAccesos.dat');
	informe(archivo);
	
END.

