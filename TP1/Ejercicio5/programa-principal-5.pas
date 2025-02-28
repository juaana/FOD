{
   Realizar un programa para una tienda de celulares, que presente un menú con
	opciones para:
	a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
	ingresados desde un archivo de texto denominado “celulares.txt”. 
	Los registros
	correspondientes a los celulares deben contener: código de celular, nombre,
	descripción, marca, precio, stock mínimo y stock disponible.
   
}
program cinco;
type
	cadena=string[15]; 
	
	celular= record
		codigo: integer;
		nombre: String;
		descripcion: cadena;
		marca: String;
		precio: real;
		stockMin: integer;
		stockDis: integer;
	end;
	
	archivo_registros= file of celular;
	
procedure listarCelularesConStock(var aC: archivo_registros);
var
	cel: celular;
	flag: boolean;
begin
	flag:= false;
	while (not eof(aC)) do
	begin
		Read(aC, cel);
		
		if (cel.stockMin > cel.stockDis) then
		begin
			writeln('Celular con stock menor al mínimo:  Código: ', cel.codigo:7, '. Precio: $', cel.precio:7:2, '. Stock mínimo: ' ,cel.stockMin:7, '. Stock disponible: ', cel.stockDis:7, '. Nombre: ',cel.nombre:7, '. Descripción ',cel.descripcion:7, '. Marca: ', cel.marca:7, '.');
			flag:= true;
		end;
	end;
	if (flag = false) then
	begin
		Writeln('No se encontraron celulares con stock menor al mínimo');
	end;
	
	
end;

procedure buscarPorDescripcion(var aC: archivo_registros);
var
	cadenaBusqueda: cadena;
	cel: celular;
	flag: boolean;
begin
	flag := false;
	
	Writeln('Ingrese la cadena a buscar');
	Readln(cadenaBusqueda);
	Reset(aC);
	
	while (not EOF(aC)) do
	begin
		Read(aC, cel);
		
		if (Pos(LowerCase(cadenaBusqueda), LowerCase(cel.descripcion)) > 0) then
		begin
			Writeln('Celular encontrado: Código: ',cel.codigo:7, '. Precio: $', cel.precio:7:2, '. Stock mínimo: ' ,cel.stockMin:7, '. Stock disponible: ', cel.stockDis:7, '. Nombre: ',cel.nombre:7, '. Descripción ',cel.descripcion:7, '. Marca: ', cel.marca:7, '.');
			flag := true;
		end;
	end;
	
	if (not flag) then
		Writeln('No se encontraron celulares con esta descripción.');
end;


procedure seleccionarOpcion(var aC: archivo_registros);
var
	opcion: integer;
begin
	opcion:= -1;
	while (opcion <> 0 ) do
	begin
		Writeln('------------------------------------');
		Writeln('Seleccione una opción para continuar');
		Writeln('------------------------------------');
		Writeln('1. Seleccione 1 para listar todos los celulares con stock menor al mínimo');
		Writeln('2. Seleccione 2 para buscar un celular por descripción');
		Writeln('0. Seleccione 0 para finalizar');

		Readln(opcion);
		case opcion of 
		1: listarCelularesConStock(aC);
		2: buscarPorDescripcion(aC);
		0: Writeln('Programa finalizado');
		else
			Writeln('Opción inválida');
		end;
	end;
end;

procedure cargarRegistros(var aCT: text; var aC: archivo_registros);
var
	cel: celular;
begin
	while (not eof(aCT)) do
	begin
		with cel do 
		begin
			Readln(aCT, codigo, precio, marca);
			Readln(aCT, stockMin, stockDis, descripcion);
			Readln(aCT, nombre);
			Write(aC, cel);
		end;
	end
end;

procedure exportar(var aCT: text; var aC: archivo_registros);
var
	cel: celular;
begin
	while (not eof(aC)) do
	begin
		Read(aC, cel);
		with cel do 
			begin
			Writeln(aCT, codigo, precio, marca);
			Writeln(aCT, stockMin, stockDis, descripcion);
			Writeln(aCT, nombre);
			end;
	end;

end;

		
var
	aCT: Text;
	aC: archivo_registros;
	nombre: String;
BEGIN
	Writeln('Ingrese el nombre del archivo de registros');
	Readln(nombre);
	
	Assign(aCT, 'celulares.txt');
	Reset(aCT);
	
	Assign(aC, nombre + '.dat');
	Rewrite(aC);
	
	cargarRegistros(aCT, aC);
	seleccionarOpcion(aC);
	exportar(aCT, aC);
	close(aCT)
	
END.





