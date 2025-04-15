{
   
 
   
}


program ej3programacarga;

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
	
procedure cargarMaestro(var aM: maestro);
var
	prov: String[10];
	regM: datos_arg;
begin
	Rewrite(aM);
	Writeln('CARGA - ARCHIVO MAESTRO');
	Writeln('_______________________');
	Writeln('Ingrese el nombre de la provincia');
	Readln(prov);
	while (prov <> 'ZZZ') do
	begin
		regM.nombreProv:= prov;
		Writeln('Ingrese la cantidad de personas alfabetizadas');
		Readln(regM.cantPersonasAlf);
		Writeln('Ingrese la cantidad de personas encuestadas');
		Readln(regM.totalEncuestados);
		Writeln('--------------------------------------------');
		Write(aM, regM);
		Writeln('Ingrese el nombre de la provincia');
		Readln(prov);
	end;
	close(aM);
end;	
procedure cargarDetalle(var aD: detalle);
var
	prov: String[10];
	regD: datos_ext;
begin
	Rewrite(aD);
	Writeln('CARGA - ARCHIVO DETALLE');
	Writeln('_______________________');
	Writeln('Ingrese el nombre de la provincia');
	Readln(prov);
	while (prov <> 'ZZZ') do
	begin
		regD.nombreProv:= prov;
		Writeln('Ingrese el codigo de la localidad');
		Readln(regD.codigoLoc);
		Writeln('Ingrese la cantidad de personas alfabetizadas');
		Readln(regD.cantPersonasAlf);
		Writeln('Ingrese la cantidad de personas encuestadas');
		Readln(regD.totalEncuestados);
		Writeln('--------------------------------------------');
		Write(aD, regD);
		Writeln('Ingrese el nombre de la provincia');
		Readln(prov);
	end;
	close(aD);
end;	
	
var
	aM: maestro;
	aD1, aD2: detalle;
BEGIN
	Assign(aM, 'datospropios.dat');
	Assign(aD1, 'datosconsultora1.dat');
	Assign(aD2, 'datosconsultora2.dat');
	cargarMaestro(aM);
	cargarDetalle(aD1);
	cargarDetalle(aD2);
END.

