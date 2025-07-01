{
1. El encargado de ventas de un negocio de productos de limpieza desea 
administrar el stock de los productos que vende. Para ello, genera un 
archivo maestro donde figuran todos los productos que comercializa. De 
cada producto se maneja la siguiente información: 

-código de producto, 
-nombre comercial, 
-precio de venta, 
-stock actual y 
-stock mínimo. 

Diariamente se genera un archivo detalle donde se registran todas las 
ventas de productos realizadas. De cada venta se registran: código de 
producto y cantidad de unidades vendidas. Resuelve los siguientes puntos:

a. Se pide realizar un procedimiento que actualice el archivo maestro 
con el archivo detalle, teniendo en cuenta que:

i. Los archivos no están ordenados por ningún criterio.
ii. Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del archivo detalle.
   
¿Qué cambios realizaría en el procedimiento del punto anterior si se 
sabe que cada registro del archivo maestro puede ser actualizado por 0 o
1 registro del archivo detalle?

El corte de recorrido del detalle seria mientras sea <> a valor alto o hasta que encuentre el mismo codigo.
No necesito recorrer todo el archivo de ventas por cada producto.
   
}
program TP3EJ1;
const
	VA=9999;
type
	producto = record
		codigo: integer;
		nombre: String[10];
		precio: real;
		stockActual: integer;
		stockMin: integer;
	end;
	venta = record
		codigo: integer;
		cantVendidas: integer;
	end;
	
	productos = file of producto;
	ventas = file of venta;
procedure leer(var V: ventas; var dato: venta);
begin
	if(NOT(EOF(V))) then
		read(V, dato)
	else
		dato.codigo:= VA;
end;
procedure leerP(var P: productos; var dato: producto);
begin
	if(NOT(EOF(P))) then
		read(P, dato)
	else
		dato.codigo:= VA;
end;

procedure actualizarProductos(var P: productos; var V: ventas);
var
	regV: venta;
	regP: producto;
	aux, total: integer;
begin
	reset(P);
	reset(V);
	leer(V, regV);
	leerP(P, regP);
	while (regP.codigo<>VA) do
	begin
		seek(V,0);
		leer(V, regV);
		aux:= regP.codigo;
		total:= 0;
		while (regV.codigo<>VA) do
		begin
			if(regV.codigo = aux)then
			begin
				total:= total +regV.cantVendidas;
			end;
			leer(V, regV);
		end;
		regP.stockActual:= regP.stockActual -total;
		seek(P, FilePos(P)-1);
		Write(P, regP);
		if (regP.codigo <>VA) then
		begin
			leerP(P, regP);
		end;
	end;
	
	
	close(P);
	close(V);
end;
var
	P: productos;
	V: ventas;
	regP: producto;
	regV: venta;
BEGIN
	Assign(P, 'productos.dat');
	Assign(V, 'ventas.dat');

	actualizarProductos(P,V);

END.

