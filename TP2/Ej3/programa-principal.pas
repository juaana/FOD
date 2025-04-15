{
  A partir de información sobre la alfabetización en la Argentina, 
  se necesita actualizar un archivo que contiene los siguientes datos: 
  nombre de provincia, cantidad de personas alfabetizadas y total de encuestados. 
  Se reciben dos archivos detalle provenientes de dos agencias de censo diferentes, 
  dichos archivos contienen: nombre de la provincia, código de localidad, cantidad de 
  alfabetizados y cantidad de encuestados. Se pide realizar los módulos necesarios 
  para actualizar el archivo maestro a partir de los dos archivos detalle.
  NOTA: Los archivos están ordenados por nombre de provincia y en los archivos
  detalle pueden venir 0, 1 ó más registros por cada provincia.
   
   
}


program EJ3TP2;
const 
	valoralto='ZZZ';
type
	datos_arg = record
		nombreProv: String[10];
		cantPersonasAlf: integer;
		totalEncuestados: integer;
		end;
	
	datos_ext= record
		nombreProv: String[10];
		codigoLoc: integer;
		cantPersonasAlf: integer;
		totalEncuestados: integer;
	end;
	
	maestro = file of datos_arg;
	detalle = file of datos_Ext;	

procedure leer(var aD: detalle; var dato: datos_ext);
begin
	if (not (EOF(aD))) then
	begin
		read(aD, dato);
	end
	else
	begin
		dato.nombreProv:= valoralto;
	end;
end;
	
procedure actualizar(var aM: maestro; var aD: detalle);
var
	regD: datos_ext;
	regM: datos_arg;
	totalEncues, totalAlfa: integer;
	aux: String[10];
begin
	Writeln('Actualizando');
	totalEncues:= 0;
	totalAlfa:= 0;
	Reset(aM);
	Reset(aD);
	Read(aM, regM);
	leer(aD, regD);
	while(regD.nombreProv <> valoralto) do
	begin
		aux:= regD.nombreProv;
		totalEncues:= 0;
		totalAlfa:= 0;
		while (aux = regD.nombreProv) do
		begin
			totalEncues:= totalEncues + regD.totalEncuestados;
			totalAlfa:= totalAlfa + regD.cantPersonasAlf;
			leer(aD, regD);
		end;
		while(regM.nombreProv <> aux) do
		begin
			read(aM, regM);
		end;
		regM.totalEncuestados:= regM.totalEncuestados + totalEncues;
		regM.cantPersonasAlf:= regM.cantPersonasAlf + totalAlfa;
		seek(aM, filepos(aM)-1);
		write(aM, regM);
		if (not(EOF(aM))) then
		begin
			read(aM, regM);
		end;
	end;
	close(aD);
	close(aM);
	Writeln('Fin de la actualización');
end;

procedure mostrar(var aM: maestro);
var
	regM: datos_arg;
begin
	Writeln('Provincias actualizadas');
	Writeln('-----------------------');
	reset(aM);
	while(not(EOF(aM))) do
	begin
		read(aM,regM);
		Writeln('Provincia: ', regM.nombreProv);
		Writeln('Cantidad de personas alfabetizadas: ', regM.cantPersonasAlf);
		Writeln('Total encuestados: ', regM.totalEncuestados);
		Writeln('-------------------------------------');
	end;
	close(aM);
end;
var
	aM: maestro;
	aD1, aD2: detalle;
BEGIN
	Assign(aM, 'datospropios.dat');
	Assign(aD1, 'datosconsultora1.dat');
	Assign(aD2, 'datosconsultora2.dat');
	mostrar(aM);
	actualizar(aM, aD1);
	actualizar(aM, aD2);	
	mostrar(aM);
END.

