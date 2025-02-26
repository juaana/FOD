{
   1. Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. La carga finaliza
cuando se ingresa el número 30000, que no debe incorporarse al archivo. El nombre del
archivo debe ser proporcionado por el usuario desde teclado.
   
}


program untitled;
type
	archivo_enteros= file of integer;
	
var
	aEnteros: archivo_enteros;
	nomArchivo: string;
	numero: integer;
BEGIN
  Writeln('Ingrese el nombre del archivo');
  Readln(nomArchivo);
  
  Assign(aEnteros, nomArchivo + '.dat');
  Rewrite(aEnteros);
  
  writeln('Ingrese un número entero');
  readln(numero);
  while (numero <> 3000) do
  begin
	write(aEnteros, numero);
	writeln('Ingrese un número entero');
	readln(numero);
  end;
  close(aEnteros);
  writeln('Programa finalizado');
	
END.

