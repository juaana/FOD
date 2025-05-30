{
   11. Se tiene información en un archivo de las horas extras realizadas 
   por los empleados de una empresa en un mes.
   Para cada empleado se tiene la siguiente información: 
   
   departamento, división, número de empleado, categoría y cantidad de horas extras realizadas por el empleado. 
   
   Se sabe que el archivo se encuentra ordenado por departamento, luego 
   por división y, por último, por número de empleado. 
   Presentar en pantalla un listado con el siguiente formato:
Departamento
División
Número de Empleado 
Total de Hs. 

Importe a cobrar //ok

Total de horas división: ____
Monto total por división: ____
División
.................
Total horas departamento: ____
Monto total departamento: ____ //ok

Para obtener el valor de la hora se debe cargar un arreglo desde un archivo 
de texto al iniciar el programa con el valor de la hora extra para cada categoría. 
La categoría varía de 1 a 15. En el archivo de texto debe haber una línea 
para cada categoría con el número de categoría y el valor de la hora, pero el 
arreglo debe ser de valores de horas, con la posición del valor coincidente 
con el número de categoría.
   
   
}


program EJ11TP2;
const valor_alto = 9999;
type

	empleado = record
		depto: integer;
		division: integer;
		numEmp: integer;
		cat : integer;
		cantHsExtra: integer;
	end;
	
	tArregloHs = array[1..15] of real;
	archivoEmpleados= file of empleado;
	
procedure cargarArregloHs(var hsExtra: text; var arregloHs: tArregloHs);
var
	valor: real;
	i: integer;
begin
	i:= 1; 
	reset(hsExtra);
	while not eof(hsExtra) do
	begin
		readln(hsExtra, valor);
		arregloHs[i] := valor;
		i:= i+1;
	end;
	close(hsExtra);
end;


procedure leer(var archivo: archivoEmpleados; var dato: empleado);
begin
	if (NOT (EOF(archivo))) then
	begin
		read(archivo, dato);
	end
	else
		begin
			dato.depto:= valor_alto;
		end;

end;

procedure imprimir(var archivo: archivoEmpleados; var precioHs: tArregloHs);
var
	dato: empleado;
	importeEmpleado, importeDiv, importeDepto: real;
	totalHsDiv, totalHsDepto: integer;
	actualDepto, actualDiv, actualEmp: integer;
begin
	reset(archivo);
	leer(archivo, dato);
	while (dato.depto <> valor_alto) do
	begin
		actualDepto := dato.depto;
		importeDepto := 0;
		totalHsDepto := 0;
		writeln('Departamento ', actualDepto);
		while (dato.depto = actualDepto) do
		begin
			actualDiv := dato.division;
			importeDiv := 0;
			totalHsDiv := 0;
			writeln('  División ', actualDiv);
			while (dato.depto = actualDepto) and (dato.division = actualDiv) do
			begin
				actualEmp := dato.numEmp;
				writeln('    Empleado ', actualEmp);
				importeEmpleado := 0;
				while (dato.depto = actualDepto) and (dato.division = actualDiv) and (dato.numEmp = actualEmp) do
				begin
					writeln('      Cantidad de horas: ', dato.cantHsExtra);
					importeEmpleado := (importeEmpleado + (dato.cantHsExtra * precioHs[dato.cat]));
					totalHsDiv := totalHsDiv + dato.cantHsExtra;
					totalHsDepto := totalHsDepto + dato.cantHsExtra;
					leer(archivo, dato);
				end;
				writeln('    Importe a cobrar: ', importeEmpleado:0:2);
				importeDiv := importeDiv + importeEmpleado;
				
			end;
			writeln('  Total de horas división: ', totalHsDiv);
			writeln('  Monto total por división: ', importeDiv:0:2);
			importeDepto := importeDepto + importeDiv;
		end;
		writeln('Total de horas departamento: ', totalHsDepto);
		writeln('Monto total departamento: ', importeDepto:0:2);
	end;
	close(archivo);
end;

var
	precios: tArregloHs;
	archivo: archivoEmpleados;
	archivoTexto: text;
	i: integer;
begin
	
	assign(archivoTexto, 'precios.txt');
	cargarArregloHs(archivoTexto, precios);
	for i := 1 to 15 do
	begin
	Writeln(precios[i]);
	end;

	

	assign(archivo, 'empleados.dat');
	imprimir(archivo, precios);
end.
