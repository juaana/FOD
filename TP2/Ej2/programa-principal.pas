{
  El encargado de ventas de un negocio de productos de limpieza desea 
  administrar el stock de los productos que vende. Para ello, genera un 
  archivo maestro donde figuran todos los productos que comercializa. 
  De cada producto se maneja la siguiente información: código de producto, nombre comercial, 
  precio de venta, stock actual y stock mínimo. Diariamente se genera un archivo detalle donde 
  se registran todas las ventas de productos realizadas. De cada venta se registran: 
  código de producto y cantidad de unidades vendidas. Se pide realizar un programa con opciones para:
  
a. Actualizar el archivo maestro con el archivo detalle, sabiendo que:
● Ambos archivos están ordenados por código de producto.
● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del archivo detalle.
● El archivo detalle sólo contiene registros que están en el archivo maestro.
b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo stock actual 
esté por debajo del stock mínimo permitido.  
   
}


program EJ2TP2;
const
	valoralto = 1000;
type

	producto = record
		codigo: integer;
		nombre: String[10];
		precioVenta: real;
		stock: integer;
		stockMin: integer;
		end;
		
	ventas = record
		cod:integer;
		cantUnidades: integer;
	end;
	
	maestro= file of producto;
	detalle= file of ventas;
	
	
	
procedure leer(var archivo: detalle; var dato: ventas);
begin
	if (not (EOF(archivo))) then
	begin
		read(archivo, dato);
	end
	else
		dato.cod:= valoralto;
end;
procedure actualizar(var aD: detalle; var aM: maestro);
var
	regD: ventas;
	regM: producto;
	aux, total :integer;
	
begin

	reset(aM);
	reset(aD);
	read(aM, regM);
	leer(aD, regD);
	Writeln('Inicio de actualización');
	while(regD.cod<>valoralto) do
	begin
		aux:= regD.cod;
		total:=0;
		while (aux = regD.cod) do
		begin
			total:= total+regD.cantUnidades;
			leer(aD, regD);
		end;
		while (regM.codigo <> aux) do
		begin
			read(aM, regM);
		end;
		regM.stock:= regM.stock - total;
		seek(aM, filepos(aM)-1);
		write(aM, regM);
		if (not (EOF(aM)))then
		begin
			read(aM, regM);
		end;
	end;
	
	close(aM);
	close(aD);
	Writeln('Fin de la actualización');
end;

procedure mostrar(var aM: maestro);
var
	regM: producto;
begin
	Reset(aM);
	Writeln('Productos');
	while (not EOF(aM)) do
	begin
		read(aM, regM);
		Writeln('Producto ', regM.codigo);
		Writeln(' Nombre: ', regM.nombre);
		Writeln(' Precio: $', regM.precioVenta:0:2);
		Writeln(' Stock: ', regM.stock);
		Writeln(' Stock mínimo: ', regM.StockMin);
	end;
	close(aM);
end;

procedure listarProductosFaltanteStock(var aM: maestro; var aStock: text);
var
	regM: producto;
begin
	Assign(aStock, 'stock_minimo.txt');
	Rewrite(aStock);
	Reset(aM);
	Writeln('------------------------------');
	Writeln('Exportando productos faltantes');
	Writeln('------------------------------');
	while (not(EOF(aM))) do
	begin
		read(aM, regM);
		if (regM.stock < regM.stockMin) then
		begin
			Writeln(aStock,' ' ,regM.codigo,' ' , regM.nombre, ' ' ,regM.precioVenta:2:0, ' ' ,regM.stock ,' ' , regM.stockMin);
		end
	end;
	close(aStock);
	close(aM);
	Writeln('Productos exportados con éxito');
	Writeln('------------------------------');
end;

var
aM: maestro;
aD: detalle;
aStock: text;
BEGIN
	Assign(aM, 'archivoMaestro.dat');
	Assign(aD, 'archivoDetalle.dat');
	
	mostrar(aM);
	actualizar(aD, aM);
	mostrar(aM);
	listarProductosFaltanteStock(aM, aStock);
	
END.

