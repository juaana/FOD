program EJ10TP2;
const
	valor_alto= 9999;
type
	mesa = record
		codProv: integer;
		codLoc: integer;
		numMesa: integer;
		cantidadVotos: integer;
	end;
	
	archivoMesa= file of mesa; 

procedure leer(var archivo: archivoMesa; var regA: mesa);
begin
	if (not EOF(archivo)) then
		read(archivo, regA)
	else
		regA.codProv := valor_alto;
end;

procedure imprimir(var archivo: archivoMesa);
var
	dato: mesa;
	totalVotos, totalProv, totalLoc: integer;
	prov, loc: integer;
begin
	reset(archivo);
	leer(archivo, dato);
	totalVotos := 0;
	
	while (dato.codProv <> valor_alto) do
	begin
		writeln('Código de provincia: ', dato.codProv);
		prov := dato.codProv;
		totalProv := 0; 
		while (dato.codProv = prov) do
		begin
			writeln('Código de localidad: ', dato.codLoc);
			loc := dato.codLoc;
			totalLoc := 0;
			while (dato.codProv = prov) AND (dato.codLoc = loc) do
			begin
				totalLoc := totalLoc + dato.cantidadVotos;
				leer(archivo, dato);
			end;
			writeln('Total de votos de la localidad ', totalLoc);
			totalProv := totalProv + totalLoc;
		end;
		writeln('Total de votos de la provincia  ', totalProv);
		totalVotos := totalVotos + totalProv;
	end; 
	
	writeln('Total de votos  ', totalVotos);
	close(archivo);
end;

var
	archivo: archivoMesa;

begin
	assign(archivo, 'mesas.dat');
	imprimir(archivo);
end.
