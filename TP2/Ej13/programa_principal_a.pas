{
   Suponga que usted es administrador de un servidor de correo electrónico. 
   En los logs del mismo (información guardada acerca de los movimientos que ocurren en el server) 
   que se encuentra en la siguiente ruta: /var/log/logmail.dat se guarda la siguiente información: 
   nro_usuario, nombreUsuario, nombre, apellido, cantidadMailEnviados. 
   
   Diariamente el servidor de correo genera un archivo con la siguiente información: 
   nro_usuario, cuentaDestino, cuerpoMensaje. 
   
   
   Este archivo representa todos los correos enviados por los usuarios 
   en un día determinado. 
   
   Ambos archivos están ordenados por nro_usuario y se sabe que un 
   usuario puede enviar cero, uno o más mails por día.
   
a. Realice el procedimiento necesario para actualizar la información del log en un día particular. 
Defina las estructuras de datos que utilice su procedimiento.
   
   
}


program EJ13TP2a;
const valorAlto= 9999;

type
	
	log= record
		nroUsuario:integer;
		nombreUsuario: String[10];
		nombre: String[10];
		apellido: String[10];
		cantidadMailsEnviados: integer;
	end;
	
	exp= record
		nroUsuario: integer;
		cuentaDestino: String[10];
		cuerpoMensaje: String[20];
	end;
	
	archivoLogs= file of log;
	archivoExp= file of exp;
	
procedure leerExp(var archivo: archivoExp; var dato: exp);
begin
	if(NOT(EOF(archivo)))then
		read(archivo,dato)
	else
		dato.nroUsuario:= valorAlto;
end;	
procedure leerLog(var archivo: archivoLogs; var dato: log);
begin
	if(NOT(EOF(archivo)))then
		read(archivo,dato)
	else
		dato.nroUsuario:= valorAlto;
end;	
procedure actualizar(var archivoL: archivoLogs; var archivoE: archivoExp);
var
	dataE: exp;
	dataL: log;
	nroActual: integer;
	contadorMails: integer;
begin	
	reset(archivoL);
	reset(archivoE);
	leerLog(archivoL, dataL);
	leerExp(archivoE, dataE);
	
	while (dataL.nroUsuario <> valorAlto) do
	begin
		nroActual:= dataL.nroUsuario;
		contadorMails:= 0;
		while (dataE.nroUsuario = nroActual) do
		begin
			contadorMails:= contadorMails + 1;
			leerExp(archivoE, dataE);
		end;
		dataL.cantidadMailsEnviados:= dataL.cantidadMailsEnviados + contadorMails;
		seek(archivoL, filePos(archivoL)-1);
		Write(archivoL, dataL);
		leerLog(archivoL, dataL);
		
	end;
	close(archivoL);
	close(archivoE);
end;

var
	archivoL: archivoLogs;
	archivoE: archivoExp;
	l: log;
BEGIN
	Assign(archivoL, 'logmail.dat');
	Assign(archivoE, 'expedientes.dat');
	actualizar(archivoL, archivoE);
	
END.

