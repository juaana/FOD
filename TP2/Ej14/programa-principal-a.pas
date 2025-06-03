{
  Una compañía aérea dispone de un archivo maestro donde guarda información
  sobre sus próximos vuelos. En dicho archivo se tiene almacenado el 
  
  destino, fecha, hora de salida y la cantidad de asientos disponibles. 
  
  La empresa recibe todos los días dos archivos detalles para actualizar 
  el archivo maestro. 
  
  En dichos archivos se tiene destino, fecha, hora de salida y cantidad de asientos comprados.
  
  Se sabe que los archivos están ordenados por destino más fecha y hora de salida,
  y que en los detalles pueden venir 0, 1 ó más registros por cada uno del maestro. Se pide realizar los módulos necesarios para:
a. Actualizar el archivo maestro sabiendo que no se registró ninguna venta de pasaje sin asiento disponible.
   
}


program EJ14TP2;
const valorAlto= 'ZZZ';

type 
	vuelo = record
		destino: String[10];
		fecha: integer;
		hora:integer;
		cantidadAsientos: integer;
	end;
	
	arch= file of vuelo;

procedure leer ( var archivo: arch; var data: vuelo);
begin
	if(NOT(EOF(archivo))) then
		read(archivo,data)
	else
		data.destino:= valorAlto;
end;

procedure minimo(var d1, d2: arch; var r1, r2, rMin: vuelo);
begin
  if (r1.destino < r2.destino) or 
     ((r1.destino = r2.destino) and (r1.fecha < r2.fecha)) or
     ((r1.destino = r2.destino) and (r1.fecha = r2.fecha) and (r1.hora < r2.hora)) then
  begin
    rMin := r1;
    leer(d1, r1);
  end
  else
  begin
    rMin := r2;
    leer(d2, r2);
  end;
end;

procedure actualizar(var maestro, det1, det2: arch);
var
  regM, r1, r2, rMin: vuelo;
  encontrado: boolean;
begin
  reset(maestro);
  reset(det1);
  reset(det2);
  
  leer(det1, r1);
  leer(det2, r2);
  leer(maestro, regM);
  
  minimo(det1, det2, r1, r2, rMin);
  
  while (rMin.destino <> valorAlto) do
  begin
    encontrado := false;
    // Buscar el vuelo correspondiente en maestro
    while ((regM.destino <> rMin.destino) or (regM.fecha <> rMin.fecha) or (regM.hora <> rMin.hora)) and (regM.destino <> valorAlto) do
      leer(maestro, regM);
    
    if regM.destino <> valorAlto then
      encontrado := true;
    
    if encontrado then
    begin
      // Restar las ventas del detalle al maestro
      while (regM.destino = rMin.destino) and (regM.fecha = rMin.fecha) and (regM.hora = rMin.hora) do
      begin
        regM.cantidadAsientos := regM.cantidadAsientos - rMin.cantidadAsientos;
        minimo(det1, det2, r1, r2, rMin);
      end;
      
      seek(maestro, filepos(maestro) - 1);
      write(maestro, regM);
    end
    else
    begin
      // Si no lo encontró, igual avanzo el minimo para evitar ciclo infinito
      minimo(det1, det2, r1, r2, rMin);
    end;
  end;
  
  close(maestro);
  close(det1);
  close(det2);
end;


var
 maestro, det1, det2: arch;
 
 
BEGIN
	assign(maestro, 'maestro.dat');
	assign(det1, 'detalle1.dat');
	assign(det2, 'detalle2.dat');
	
	actualizar(maestro, det1, det2);

END.
