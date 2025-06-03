{
   Suponga que usted es administrador de un servidor de correo electrónico. 
   En los logs del mismo (información guardada acerca de los movimientos que ocurren en el server) 
   que se encuentra en la siguiente ruta: /var/log/logmail.dat se guarda la siguiente información: 
   nro_usuario, nombreUsuario, nombre, apellido, cantidadMailEnviados. 
   
   Diariamente el servidor de correo genera un archivo con la siguiente información: 
   nro_usuario, cuentaDestino, cuerpoMensaje. 
   
   
   Genere un archivo de texto que contenga el siguiente informe dado un archivo detalle de un día determinado:
	nro_usuarioX…………..cantidadMensajesEnviados
Nota: tener en cuenta que en el listado deberán aparecer todos los usuarios que existen en el sistema. Considere la implementación de esta opción de las siguientes maneras:
i- Como un procedimiento separado del punto a).
ii- En el mismo procedimiento de actualización del punto a). Qué cambios se requieren en el procedimiento del punto a) para realizar el informe en el mismo recorrido?
   
   
}


program EJ13TP2;
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
procedure actualizar(var archivoL: archivoLogs; var archivoE: archivoExp; var archivoT: text);
var
	dataE: exp;
	dataL: log;
	nroActual: integer;
	contadorMails: integer;
begin	
	reset(archivoL);
	reset(archivoE);
	rewrite(archivoT);
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
		Writeln(archivoT, dataL.nroUsuario,' ', dataL.cantidadMailsEnviados);
			
		leerLog(archivoL, dataL);
		
	end;
	close(archivoL);
	close(archivoE);
	close(archivoT);
end;

var
	archivoL: archivoLogs;
	archivoE: archivoExp;
	archivoT: text;
BEGIN
	Assign(archivoL, 'logmail.dat');
	Assign(archivoE, 'expedientes.dat');
	Assign(archivoT, 'exportacion.txt');
	actualizar(archivoL, archivoE, archivoT);
	
	
END.

