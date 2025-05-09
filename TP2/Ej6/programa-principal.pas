{
   6. Se desea modelar la información necesaria para un sistema de recuentos 
   de casos de covid para el ministerio de salud de la provincia de buenos aires.
   
	Diariamente se reciben archivos provenientes de los distintos municipios, 
	la información contenida en los mismos es la siguiente: 
	código de localidad, 
	código cepa, 
	cantidad de casos activos, 
	cantidad de casos nuevos, 
	cantidad de casos recuperados, 
	cantidad de casos fallecidos.
	
	El ministerio cuenta con un archivo maestro con la siguiente información: 
	código localidad, 
	nombre localidad, 
	código cepa, 
	nombre cepa, 
	cantidad de casos activos, 
	cantidad de casos nuevos, 
	cantidad de recuperados y 
	cantidad de fallecidos.
	-----------
	Se debe realizar el procedimiento que permita actualizar el maestro con los detalles recibidos, 
	se reciben 10 detalles. 
	Todos los archivos están ordenados por código de localidad y código de cepa.
	Para la actualización se debe proceder de la siguiente manera:
	
	1. Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.
	2. Idem anterior para los recuperados.
	3. Los casos activos se actualizan con el valor recibido en el detalle.
	4. Idem anterior para los casos nuevos hallados.
	Realice las declaraciones necesarias,
	el programa principal y los procedimientos que requiera para la actualización solicitada 
	e informe cantidad de localidades con más de 50 casos activos (las localidades pueden o no haber sido actualizadas).
   
   
}

program ActualizarMaestroCovid;
const
  valor_alto = 9999;
type
  str10 = string[10];

  datosMunicipio = record
    codLoc: integer;
    codCepa: integer; 
    cantCasosAct: integer;
    cantCasosNuev: integer;
    cantCasosRec: integer;
    cantCasosFall: integer;
  end;

  datosCentrales = record
    codLoc: integer;
    nombreLoc: str10;
    codCepa: integer; 
    nomCepa: str10;
    cantCasosAct: integer;
    cantCasosNuev: integer;
    cantCasosRec: integer;
    cantCasosFall: integer;
  end;

  detalle = file of datosMunicipio;
  maestro = file of datosCentrales;
  
procedure leer(var d: detalle; var reg: datosMunicipio);
begin
  if (not (eof(d))) then
    read(d, reg)
  else
    reg.codLoc := valor_alto;
end;

procedure minimo(var det1, det2, det3: detalle; var regD1, regD2, regD3, min: datosMunicipio);
begin
  if (regD1.codLoc <= regD2.codLoc) and (regD1.codLoc <= regD3.codLoc) then
  begin
    min := regD1;
    leer(det1, regD1);
  end
  else if (regD2.codLoc <= regD3.codLoc) then
  begin
    min := regD2;
    leer(det2, regD2);
  end
  else 
  begin
    min := regD3;
    leer(det3, regD3);
  end;
end;

procedure actualizarMaestro(var mae: maestro; var det1, det2, det3: detalle);
var
  regM: datosCentrales;
  regD1, regD2, regD3, min: datosMunicipio;
  localidadesConMasDe50: integer;
  encontrado: boolean;
begin
  localidadesConMasDe50 := 0;

  leer(det1, regD1);
  leer(det2, regD2);
  leer(det3, regD3);
  minimo(det1, det2, det3, regD1, regD2, regD3, min);

  while (min.codLoc <> valor_alto) do
  begin
    encontrado := false;
    seek(mae, 0); // Volver al inicio del archivo maestro
    
    // Buscar coincidencia en el maestro
    while (not eof(mae)) and (not encontrado) do
    begin
      read(mae, regM);
      if (regM.codLoc = min.codLoc) and (regM.codCepa = min.codCepa) then
      begin
        encontrado := true;
        // Actualización
        regM.cantCasosAct := min.cantCasosAct;
        regM.cantCasosNuev := min.cantCasosNuev;
        regM.cantCasosRec := regM.cantCasosRec + min.cantCasosRec;
        regM.cantCasosFall := regM.cantCasosFall + min.cantCasosFall;

        seek(mae, filepos(mae) - 1);
        write(mae, regM);

        if (regM.cantCasosAct > 50) then
          localidadesConMasDe50 := localidadesConMasDe50 + 1;
      end;
    end;

    if not encontrado then
      writeln('No se encontró coincidencia para codLoc: ', min.codLoc, ' codCepa: ', min.codCepa);

    minimo(det1, det2, det3, regD1, regD2, regD3, min);
  end;

  writeln('Localidades con más de 50 casos activos: ', localidadesConMasDe50);
end;

var
  mae: maestro;
  det1, det2, det3: detalle;
begin
  assign(mae, 'datosCentrales.dat');
  assign(det1, 'datosMunicipio1.dat');
  assign(det2, 'datosMunicipio2.dat');
  assign(det3, 'datosMunicipio3.dat');
  
  reset(mae);
  reset(det1);
  reset(det2);
  reset(det3);
  
  actualizarMaestro(mae, det1, det2, det3);
  
  close(det1);
  close(det2);
  close(det3);
  close(mae);
end.
