{
1. Archivos Secuenciales
Se desea automatizar el manejo de información referente a los casos positivos de 
dengue para la Provincia de Buenos Aires. Para esto se cuenta con un 
archivo maestro que contiene la siguiente información: 
-código de municipio, 
-nombre municipio y 
-cantidad de casos positivos. 

Dicho archivo está ordenado por código de municipio.

Todos los meses se reciben 30 archivos que contienen la siguiente 
información: 
-código de municipio y 
-cantidad de casos positivos. 

El orden de cada archivo detalle es por código de municipio.

En cada archivo puede venir información de cualquier municipio, un municipio puede aparecer cero 
una o más de una vez en cada archivo.

Realice el sistema completo que permita la actualización de la información 
del archivo maestro a partir de los archivos detalle recalculando la cantidad
de casos posítivos e informando por pantalla aquellos municipios 
(código y nombre) donde la cantidad total de casos positivos es mayor a 15.

Nota: cada archivo debe recorrerse una única vez.
Nota 1: Los nombres de los archivos deben pedirse por teclado. Se puede suponer que los nombres ingresados corresponden a archivos existentes.
Nota 2: El informe debe incluir cualquier municipio que cumpla la condición, independientemente de si se actualiza o no.
   
   
}


program SegundoParcial2024;
const
	dimF= 3;
	VA= 9999;
type
	
	subrango= 1..dimF;
	
	denguePBA = record
		codigoMunicipio: integer;
		nombre: String[10];
		cantidadCasosPositivos: integer;
	end;
	dengueMunicipio = record
		codigoMunicipio: integer;
		cantidadCasosPositivos: integer;
	end;
	
	maestro = file of denguePBA;
	detalle= file of dengueMunicipio;
	
	detalles= array [subrango] of detalle;
	registrosD= array [subrango] of dengueMunicipio;
procedure leer(var archivo: detalle; var dato: dengueMunicipio);
begin
	if (NOT(EOF(archivo))) then
		read(archivo, dato)
	else
		dato.codigoMunicipio:= VA;
end;	

procedure minimo(var regD: registrosD; var D: detalles; var min: dengueMunicipio);
var
i, pos: integer;
encontro: boolean;
begin
	min.codigoMunicipio := VA;
	pos := 1;
	encontro := false;
	for i := 1 to dimF do
	begin
		if (regD[i].codigoMunicipio < min.codigoMunicipio) then
		begin
			min:= regD[i];
			pos:= i;
			encontro:= true;
		end;
	end; 
	if (encontro) then
	begin
		leer(D[pos], regD[pos]);
	end;
end;


procedure actualizacion(var M: maestro; var D: detalles);
var
  regM: denguePBA;
  regD: registrosD;
  minD: dengueMunicipio;
  i, suma: integer;
begin
  // 1) Abrir maestro en modo lectura/escritura
  reset(M);

  // 2) Abrir y leer el primer registro de cada detalle
  for i := 1 to dimF do begin
    reset(D[i]);
    leer(D[i], regD[i]);
  end;

  // 3) Traigo el mínimo de los detalles
  minimo(regD, D, minD);

  // 4) Recorro el maestro
  while not EOF(M) do begin
    read(M, regM);

    // acumulador para este municipio
    suma := 0;

    // mientras el min coincide con el código actual del maestro
    while (minD.codigoMunicipio <> VA) and
          (minD.codigoMunicipio = regM.codigoMunicipio) do
    begin
      suma := suma + minD.cantidadCasosPositivos;
      minimo(regD, D, minD);
    end;

    // si encontré alguno, actualizo cantidadCasosPositivos
    if suma > 0 then begin
      regM.cantidadCasosPositivos := regM.cantidadCasosPositivos + suma;
      // vuelvo un paso para reescribir
      seek(M, FilePos(M)-1);
      write(M, regM);
    end;

    // informe inmediato si supera 15
    if regM.cantidadCasosPositivos > 15 then
      writeln('El Municipio ', regM.codigoMunicipio,
              ' ', regM.nombre, ' tiene ',
              regM.cantidadCasosPositivos, ' casos.');

  end;

  close(M);
  // cerrar detalles
  for i := 1 to dimF do
    close(D[i]);
end;
var
  M: maestro;
  D: detalles;
  i: integer;
  nombreArchivo: String[20];
begin
  // pedir nombre del maestro
  write('Nombre del archivo maestro: ');
  readln(nombreArchivo);
  Assign(M, nombreArchivo);

  // pedir nombre de cada detalle
  for i := 1 to dimF do begin
    write('Nombre detalle ', i, ': ');
    readln(nombreArchivo);
    Assign(D[i], nombreArchivo);
  end;

  // ejecuto actualización e informe
  actualizacion(M, D);
end.
