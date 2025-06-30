{
   programacarga.pas
   
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


program programacarga;

type
 prenda = record
    codigo: integer;
    descripcion: String[20];
    colores: String[20];
    tipoPrenda: String[10];
    stock: integer;
    precioUnitario: real;
  end;

  prendas = file of prenda;
  
procedure cargarArchivo(var A: prendas);
var
	regA: prenda;
begin
	rewrite(A);
	Writeln('Comenzando la carga del maestro');
	regA.codigo:= 1;
	regA.descripcion:= 'Short argentina';
	regA.colores:= 'Celeste y blanco';
	regA.tipoPrenda:= 'Short';
	regA.stock:= 2;
	regA.precioUnitario:= 10;
	write(A, regA);
	
	regA.codigo := 2;
	regA.descripcion := 'Jean clásico';
	regA.colores := 'Azul oscuro';
	regA.tipoPrenda := 'Pantalón';
	regA.stock := 5;
	regA.precioUnitario := 40;
	write(A, regA);

	regA.codigo := 3;
	regA.descripcion := 'Campera impermeable';
	regA.colores := 'Negro';
	regA.tipoPrenda := 'Campera';
	regA.stock := 3;
	regA.precioUnitario := 60;
	write(A, regA);
	
	close(A);
	Writeln('Carga del maestro finalizada');
end;

procedure cargarTxt(var codPrendas: text);

begin
	rewrite(codPrendas);
	Writeln('Comenzando la carga de codigos de temporada');
	Writeln(codPrendas, 2);
	Writeln(codPrendas, 3);
	close(codPrendas);
	Writeln('Carga de codigos de temporada finalizada');
end;
var
	codPrendas: text;
	A: prendas;
BEGIN
	Assign(A, 'prendas.dat');
	Assign(codPrendas, 'codPrendas.txt');
	cargarArchivo(A);
	cargarTxt(codPrendas);
END.

