{
   programa-de-carga.pas
   
   Copyright 2025 Juana Zabaleta <juanazabaleta@MacBook-Air-de-Juana.local>
   
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.
   
   
}


program cargaArchivos;
type
	producto = record
		codigo: integer;
		nombre: String[10];
		precioVenta: real;
		stock: integer;
		stockMin: integer;
		end;
		
	ventas = record
		codigoProd:integer;
		cantUnidades: integer;
	end;
	
	maestro= file of producto;
	detalle= file of ventas;

procedure cargarMaesto(var aM: maestro);
var
	cod: integer;
	p: producto;
begin
	reset(aM) ;
	Writeln('Ingrese el código del producto');
	Readln(cod);
	while(cod > 0 ) do
	begin
		p.codigo:= cod;
		Writeln('Ingrese el nombre del producto');
		Readln(p.nombre);
		Writeln('Ingrese el precio de venta del producto');
		Readln(p.precioVenta);
		Writeln('Ingrese el stock del producto');
		Readln(p.stock);
		Writeln('Ingrese el stock mínimo del producto');
		Readln(p.stockMin);
		Write(aM, p);
		Writeln('Ingrese el código del producto');
		Readln(cod);
	end;
	close(aM);
	Writeln('Fin del programa cargar maestro');
end;
procedure cargarDetalle(var aD: detalle);
var
	cod: integer;
	v: ventas;
begin
	reset(aD);
	Writeln('Ingrese el código del producto');
	Readln(cod);
	while(cod > 0 ) do
	begin
		v.codigoProd:= cod;
		Writeln('Ingrese la cantidad de unidades vendidas');
		Readln(v.cantUnidades);
		Write(aD, v);
		Writeln('Ingrese el código del producto');
		Readln(cod);
	end;
	close(aD);
	Writeln('Fin del programa cargar detalle');
end;


var
	aM: maestro;
	aD: detalle;
BEGIN
	Assign(aM, 'archivoMaestro.dat');
	Assign(aD, 'archivoDetalle.dat');

	cargarMaesto(aM);
	cargarDetalle(aD);
	
END.


