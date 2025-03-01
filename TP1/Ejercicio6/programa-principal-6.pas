{
  6. Agregar al menú del programa del ejercicio 5, opciones para:
a. Añadir uno o más celulares al final del archivo con sus datos ingresados por
teclado.
b. Modificar el stock de un celular dado.
c. Exportar el contenido del archivo binario a un archivo de texto denominado:
”SinStock.txt”, con aquellos celulares que tengan stock 0.
   
}
program cinco;
type
	cadena=string[15]; 
	
	celular= record
		codigo: integer;
		precio: real;
		marca: String;
		stockMin: integer;
		stockDis: integer;
		descripcion: cadena;
		nombre: String;
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
	Seek(aC, 0);
	
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



procedure agregarCelular(var aC: archivo_registros);
var
	cel: celular;
begin
	Seek(aC, FileSize(aC)); // Mueve el puntero al final

	with cel do 
	begin
		Writeln('Ingrese el código:');
		Readln(codigo);
		Writeln('Ingrese el nombre:');
		Readln(nombre);
		Writeln('Ingrese la descripción:');
		Readln(descripcion);
		Writeln('Ingrese la marca:');
		Readln(marca);
		Writeln('Ingrese el precio:');
		Readln(precio);
		Writeln('Ingrese el stock mínimo:');
		Readln(stockMin);
		Writeln('Ingrese el stock disponible:');
		Readln(stockDis);
	end;

	Write(aC, cel);
	Writeln('Celular agregado correctamente.');
end;

procedure modificarStock(var aC: archivo_registros);
var
cel: celular;
flag: boolean;
nombre: String;
nuevoStock: integer;
begin
	flag:= false;
	Seek(aC, 0);
	
	Writeln('Ingrese el nombre del celular a modificar');
	Readln(nombre);
	
	while (not eof(aC)) and (flag = false) do
	begin
		Read(aC, cel);

		if (cel.nombre = nombre) then
		begin
			flag:= true;
			Writeln('Ingrese el nuevo stock disponible:');
			Readln(nuevoStock);
			cel.stockDis := nuevoStock;

			Seek(aC, FilePos(aC) - 1); 
			Write(aC, cel);
			Writeln('Stock actualizado.');
		end;
	end;
	if (flag = false) then
	begin
		Writeln('Celular no encontrado');
	end;
	
	
end;

procedure exportarSinStock(var aC: archivo_registros);
var
	cel: celular;
	sS: text;
begin
	Assign(sS, 'sinStock.txt');
	Rewrite(sS);
	Seek(aC, 0);
	while (not eof(aC)) do
	begin
		Read(aC, cel);
		if (cel.stockDis = 0) then
			begin
				Writeln(sS, cel.codigo, cel.precio, cel.marca);
				Writeln(sS, cel.stockMin, cel.stockDis, cel.descripcion);
				Writeln(sS, cel.nombre);		
			end;
	end;
	close(sS);
	Writeln('Archivo exportado con exito');

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
		Writeln('3. Seleccione 3 para ingresar un nuevo celular');
		Writeln('4. Seleccione 4 para modificar el stock disponible');
		Writeln('5. Seleccione 5 para exportar los celulares con stock igual 0');

		Writeln('0. Seleccione 0 para finalizar');

		Readln(opcion);
		case opcion of 
		1: listarCelularesConStock(aC);
		2: buscarPorDescripcion(aC);
		3: agregarCelular(aC);
		4: modificarStock(aC);
		5: exportarSinStock(aC);
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
	close(aCT);
	close(aC);
	Writeln('Cambios guardados');
END.





