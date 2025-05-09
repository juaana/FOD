program CrearArchivos;
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
  archivo1, archivo2, archivo3: detalle;
  archivoMaestro: maestro;
  regD: datosMunicipio;
  regM: datosCentrales;

begin
  assign(archivo1, 'datosMunicipio1.dat');
  assign(archivo2, 'datosMunicipio2.dat');
  assign(archivo3, 'datosMunicipio3.dat');
  assign(archivoMaestro, 'datosCentrales.dat');
  
  rewrite(archivo1);
  regD.codLoc := 1; regD.codCepa := 101; regD.cantCasosAct := 100; regD.cantCasosNuev := 10; regD.cantCasosRec := 90; regD.cantCasosFall := 5;
  write(archivo1, regD);
  regD.codLoc := 2; regD.codCepa := 102; regD.cantCasosAct := 200; regD.cantCasosNuev := 30; regD.cantCasosRec := 180; regD.cantCasosFall := 10;
  write(archivo1, regD);
  close(archivo1);
  
  rewrite(archivo2);
  regD.codLoc := 5; regD.codCepa := 105; regD.cantCasosAct := 150; regD.cantCasosNuev := 20; regD.cantCasosRec := 130; regD.cantCasosFall := 7;
  write(archivo2, regD);
  regD.codLoc := 6; regD.codCepa := 106; regD.cantCasosAct := 250; regD.cantCasosNuev := 35; regD.cantCasosRec := 215; regD.cantCasosFall := 15;
  write(archivo2, regD);
  close(archivo2);
  
  rewrite(archivo3);
  regD.codLoc := 9; regD.codCepa := 109; regD.cantCasosAct := 120; regD.cantCasosNuev := 15; regD.cantCasosRec := 105; regD.cantCasosFall := 6;
  write(archivo3, regD);
  regD.codLoc := 10; regD.codCepa := 110; regD.cantCasosAct := 220; regD.cantCasosNuev := 25; regD.cantCasosRec := 195; regD.cantCasosFall := 12;
  write(archivo3, regD);
  close(archivo3);
  
  rewrite(archivoMaestro);
  regM.codLoc := 1; regM.nombreLoc := 'Localidad1'; regM.codCepa := 101; regM.nomCepa := 'CepaA'; regM.cantCasosAct := 100; regM.cantCasosNuev := 10; regM.cantCasosRec := 90; regM.cantCasosFall := 5;
  write(archivoMaestro, regM);
  regM.codLoc := 2; regM.nombreLoc := 'Localidad2'; regM.codCepa := 102; regM.nomCepa := 'CepaB'; regM.cantCasosAct := 200; regM.cantCasosNuev := 30; regM.cantCasosRec := 180; regM.cantCasosFall := 10;
  write(archivoMaestro, regM);
  close(archivoMaestro);
  
end.
