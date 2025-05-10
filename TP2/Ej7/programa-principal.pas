{
   Se dispone de un archivo maestro con información de los alumnos de la 
   Facultad de Informática. Cada registro del archivo maestro contiene: 
   código de alumno, apellido, nombre, cantidad de cursadas aprobadas y
   cantidad de materias con final aprobado. El archivo maestro está 
   ordenado por código de alumno.
   
   Además, se tienen dos archivos detalle con información sobre el 
   desempeño académico de los alumnos: un archivo de cursadas y un
   archivo de exámenes finales.
   
   El archivo de cursadas contiene información sobre las materias cursadas por los alumnos. 
   Cada registro incluye: código de alumno, código de materia, 
   año de cursada y resultado (solo interesa si la cursada 
   fue aprobada o desaprobada). 
   
   Por su parte, el archivo de exámenes 
   finales contiene información sobre los exámenes finales rendidos. 
   Cada registro incluye: código de alumno, código de materia,
   fecha del examen y nota obtenida. 
   
   Ambos archivos detalle están 
   ordenados por código de alumno y código de materia, 
   y pueden contener 0, 1 o más registros por alumno en el archivo 
   maestro. 
   Un alumno podría cursar una materia muchas veces,
   así como también podría rendir el final de una materia en múltiples ocasiones.
   
   Se debe desarrollar un programa que actualice el archivo maestro, 
   ajustando la cantidad de cursadas aprobadas y la cantidad de materias
   con final aprobado, utilizando la información de los archivos detalle. 
   Las reglas de actualización son las siguientes:
   
   - Si un alumno aprueba una cursada, se incrementa en uno 
   la cantidad de cursadas aprobadas.
   - Si un alumno aprueba un examen final (nota >= 4), 
   se incrementa en uno la cantidad de materias con final aprobado.'
   
   Notas:
	* Los archivos deben procesarse en un único recorrido.
	* No es necesario comprobar que no haya inconsistencias en la 
	información de los archivos detalles. Esto es, no puede suceder que 
	un alumno apruebe más de una vez la cursada de una misma materia 
	(a lo sumo la aprueba una vez), algo similar ocurre con los 
	exámenes finales.
	
	
	Cosas que tengo que hacer: 
	
	Leo el maestro 
	Leo detalle
	Reinicio totales;
	Comparo lo que lei en maestro con lo que lei en detalleCursada
	Si no son iguales sigo buscando, sino asigno el registro del detalleCursada actual a auxiliar
	Hago un corte de control en el detalle fijandome de estar hablando siempre de la misma persona en detalle cursada
	Dentro de un bucle acumulo en total Cursada
	Leo el siguiente registro de cursada
	
	
	
	Comparo lo que lei en maestro con lo que lei en detalleFinal
	Si no son iguales sigo buscando, sino asigno el registro del detalleFinal actual a auxiliar
	Hago un corte de control en el detalle fijandome de estar hablando siempre de la misma persona en detalle final
	Dentro de un bucle acumulo en total Final
	Leo el siguiente registro de final
	
	sumo el acumulado a maestro (asegurarme de que el puntero este bien posicionado)
}


program EJ7TP2;
const valorAlto= 9999;
notaMinimaFinal= 4;
type
	alumno = record
		codAlumno: integer;
		apellido: String[10];
		nombre: String[10];
		cantCursadasAprobadas: integer;
		cantFinalesAprobados: integer;
		end; 
	cursada= record
		codAlumno: integer;
		codMateria: integer;
		anoExamen: integer;
		resultado: String[12];
		end; 
		
	finales= record
		codAlumno: integer;
		codMateria: integer;
		fechaExamen: String[10];
		notaFinal: real;
	end;
	
	
	maestro = file of alumno;
	detalleCursada= file of cursada;
	detalleFinal= file of finales;
	

procedure leer(var archivo: maestro; var registro: alumno);
begin
	if (not (EOF(archivo))) then
	begin
		read(archivo, registro);
	end
	else
		begin
			registro.codAlumno:= valorAlto;
		end;
end;
	
procedure leerCursada(var archivo: detalleCursada; var reg: cursada);
begin
	if (not EOF(archivo)) then
		read(archivo, reg)
	else
		reg.codAlumno := valorAlto; 
end;
procedure leerFinal(var archivo: detalleFinal; var reg: finales);
begin
	if (not EOF(archivo)) then
		read(archivo, reg)
	else
		reg.codAlumno := valorAlto; 
end;

procedure actualizarMaestro(var aM: maestro; var aDC: detalleCursada; var aDF: detalleFinal);
var
	regM: alumno;
	regC: cursada;
	regF: finales;
	totalCursada, totalFinal: integer;
begin
	Reset(aM);
	Reset(aDC);
	Reset(aDF);
	leer(aM, regM);
	leerCursada(aDC, regC);
	leerFinal(aDF, regF);
	
	while (regM.codAlumno <> valorAlto) do
	begin
		totalCursada := 0;
		totalFinal:=0;
		while (regC.codAlumno = regM.codAlumno) do
		begin
			if (regC.resultado = 'aprobado') then
				totalCursada := totalCursada + 1;
			leerCursada(aDC, regC);

		end;
		while (regF.codAlumno = regM.codAlumno) do
		begin
			if (regF.notaFinal >= notaMinimaFinal) then
				totalFinal:= totalFinal +1;
			leerFinal(aDF, regF);
		
		end;
		regM.cantCursadasAprobadas := regM.cantCursadasAprobadas + totalCursada;
		regM.cantFinalesAprobados:= regM.cantFinalesAprobados +totalFinal;
		seek(aM, filepos(aM) - 1);
		write(aM, regM);
		leer(aM, regM);
	end;

	Close(aM);
	Close(aDC);
	Close(aDF);
end;

var
	aM: maestro;
	aDC: detalleCursada;
	aDF: detalleFinal;
BEGIN
	Assign(aM, 'alumnos.dat');
	Assign(aDC, 'detalleCursadas.dat');
	Assign(aDF, 'detalleFinal.dat');
	
	actualizarMaestro(aM, aDC, aDF);

END.

