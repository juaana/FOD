{
   6. Una cadena de tiendas de indumentaria posee un archivo maestro no 
   ordenado con la información correspondiente a las prendas que se 
   encuentran a la venta. 
   De cada prenda se registra: 
   
   cod_prenda, 
   descripción, 
   colores, 
   tipo_prenda, 
   stock y 
   precio_unitario. 
   
   Ante un eventual cambio de temporada, se deben actualizar las prendas a la 
   venta. 
   
   Para ello reciben un archivo conteniendo: cod_prenda de las
   prendas que quedarán obsoletas. Deberá implementar un procedimiento 
   que reciba ambos archivos y realice la baja lógica de las prendas, 
   para ello deberá modificar el stock de la prenda correspondiente a 
   valor negativo.
   
   Adicionalmente, deberá implementar otro procedimiento que se encargue 
   de efectivizar las bajas lógicas que se realizaron sobre el archivo 
   maestro con la información de las prendas a la venta. Para ello se 
   deberá utilizar una estructura auxiliar (esto es, un archivo nuevo), 
   en el cual se copien únicamente aquellas prendas que no están 
   marcadas como borradas. Al finalizar este proceso de compactación del
   archivo, se deberá renombrar el archivo nuevo con el nombre del 
   archivo maestro original.
   
   
}
program TP3EJ6;
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

procedure bajaPorTemporada(var A: prendas; var codA: text);
var
  regA: prenda;
  cod: integer;
  encontrado: boolean;
begin
  reset(A);
  while (NOT(EOF(A))) do
  begin
    read(A, regA);
    reset(codA);
    encontrado := false;

    while (NOT(EOF(codA))) and (NOT(encontrado)) do
    begin
      readln(codA, cod);
      if regA.codigo = cod then
        encontrado := true;
    end;

    if (encontrado) then
    begin
      regA.stock := -regA.stock;  
      seek(A, filePos(A) - 1);               
      write(A, regA);
    end;
  end;
  close(A);
  close(codA);
end;


var
 A: prendas;
 codA: text;
 regA: prenda;
BEGIN
  Assign(A, 'prendas.dat');
  Assign(codA, 'codPrendas.txt');
  reset(A);
  while(NOT(EOF(A)))do
  begin
	read(A, regA);
	Writeln('Código: ',regA.codigo,'. Stock: ', regA.stock); 
  end;
  close(A);
  bajaPorTemporada(A, codA);
    reset(A);
  while(NOT(EOF(A)))do
  begin
	read(A, regA);
	Writeln('Código: ',regA.codigo,'. Stock: ', regA.stock); 
  end;
  close(A);
  
END.
