program cinco;

type

  cadena=string[15];
  
  celular = record
    codigo: integer;
    nombre: String;
    descripcion: cadena;
    marca: String;
    precio: real;
    stockMin: integer;
    stockDis: integer;
  end;



var
  aCT: text;
  cel: celular;
begin
  Assign(aCT, 'celulares.txt');
  Rewrite(aCT);
  
  with cel do
  begin
  Writeln('Ingrese el codigo del celular');
  Readln(codigo);
  while codigo <> 0 do
	begin
		Writeln('Ingrese el nombre del celular');
		Readln(nombre);
		Writeln('Ingrese la descripción del celular');
		Readln(descripcion);
		Writeln('Ingrese la marca del celular');
		Readln(marca);
		Writeln('Ingrese el precio del celular');
		Readln(precio);
		Writeln('Ingrese el stock mínimo del celular');
		Readln(stockMin);
		Writeln('Ingrese el stock disponible del celular');
		Readln(stockDis);
		Writeln(aCT, cel.codigo,' ' ,cel.precio,' ' ,cel.marca);
		Writeln(aCT,cel.stockDis, ' ' ,cel.stockMin, ' ',cel.descripcion);
		Writeln(aCT, cel.nombre);
		Writeln('Ingrese el codigo del celular');
		Readln(codigo);
	end;
	
	
  end;
  


  Close(aCT);
  
end.
