{
2. Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
creado en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y el
promedio de los números ingresados. El nombre del archivo a procesar debe ser
proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
contenido del archivo en pantalla.
}


program untitled;
type
	archivo_enteros= file of integer;
	
var
	aEnteros: archivo_enteros;
	nomArchivo: string;
	numero,  cantidad, suma: integer;
	promedio: double;
BEGIN
  cantidad:= 0 ;
  promedio:= 0;
  suma:= 0;
  numero:=0;
  Writeln('Ingrese el nombre del archivo a leer');
  Readln(nomArchivo);
  Assign(aEnteros, nomArchivo + '.dat');
  Reset(aEnteros);
  Writeln('Contenido del archivo');
  while (not eof(aEnteros)) do
  begin
	Read(aEnteros, numero);
	if( numero < 1500) then
	begin
		cantidad:= cantidad +1;
		suma:= suma + numero;		
	end;
	Writeln(numero);
  end;
  close(aEnteros);
  if (cantidad > 0) then
  begin
    promedio := suma / cantidad;
    Writeln('El promedio de los números menores a 1500 es: ', promedio:0:2);
  end
  else
    Writeln('No hay números menores a 1500 en el archivo.');

  Writeln('Programa finalizado.'); 

END.

