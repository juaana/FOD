program CrearDatos;
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

var
  mae: maestro;
  det1, det2, det3: detalle;
  regM: datosCentrales;
  regD: datosMunicipio;
begin
  // Crear archivo maestro
  assign(mae, 'datosCentrales.dat');
  rewrite(mae);
  
  // Datos para el archivo maestro
  regM.codLoc := 1;
  regM.nombreLoc := 'Quilmes';
  regM.codCepa := 1;
  regM.nomCepa := 'Delta';
  regM.cantCasosAct := 30;
  regM.cantCasosNuev := 5;
  regM.cantCasosRec := 100;
  regM.cantCasosFall := 10;
  write(mae, regM);

  regM.codLoc := 1;
  regM.nombreLoc := 'Quilmes';
  regM.codCepa := 2;
  regM.nomCepa := 'Omicron';
  regM.cantCasosAct := 40;
  regM.cantCasosNuev := 8;
  regM.cantCasosRec := 80;
  regM.cantCasosFall := 5;
  write(mae, regM);

  regM.codLoc := 2;
  regM.nombreLoc := 'Avellaneda';
  regM.codCepa := 1;
  regM.nomCepa := 'Delta';
  regM.cantCasosAct := 60;
  regM.cantCasosNuev := 10;
  regM.cantCasosRec := 120;
  regM.cantCasosFall := 15;
  write(mae, regM);

  close(mae);

  // Crear archivo detalle 1
  assign(det1, 'datosMunicipio1.dat');
  rewrite(det1);
  
  regD.codLoc := 1;
  regD.codCepa := 1;
  regD.cantCasosAct := 35;
  regD.cantCasosNuev := 5;
  regD.cantCasosRec := 2;
  regD.cantCasosFall := 1;
  write(det1, regD);

  regD.codLoc := 2;
  regD.codCepa := 1;
  regD.cantCasosAct := 65;
  regD.cantCasosNuev := 5;
  regD.cantCasosRec := 3;
  regD.cantCasosFall := 2;
  write(det1, regD);

  close(det1);

  // Crear archivo detalle 2
  assign(det2, 'datosMunicipio2.dat');
  rewrite(det2);
  
  regD.codLoc := 1;
  regD.codCepa := 2;
  regD.cantCasosAct := 45;
  regD.cantCasosNuev := 5;
  regD.cantCasosRec := 2;
  regD.cantCasosFall := 1;
  write(det2, regD);

  close(det2);

  // Crear archivo detalle 3
  assign(det3, 'datosMunicipio3.dat');
  rewrite(det3);
  
  regD.codLoc := 1;
  regD.codCepa := 1;
  regD.cantCasosAct := 55;
  regD.cantCasosNuev := 10;
  regD.cantCasosRec := 5;
  regD.cantCasosFall := 2;
  write(det3, regD);

  close(det3);

  writeln('Archivos de prueba creados exitosamente.');
end. 