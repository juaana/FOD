program LeerMaestro;
type
  str10 = string[10];

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

  maestro = file of datosCentrales;

var
  mae: maestro;
  reg: datosCentrales;
begin
  assign(mae, 'datosCentrales.dat');
  reset(mae);
  
  writeln('Contenido del archivo maestro:');
  writeln('----------------------------');
  
  while not eof(mae) do
  begin
    read(mae, reg);
    writeln('Localidad: ', reg.nombreLoc, ' (', reg.codLoc, ')');
    writeln('Cepa: ', reg.nomCepa, ' (', reg.codCepa, ')');
    writeln('Casos activos: ', reg.cantCasosAct);
    writeln('Casos nuevos: ', reg.cantCasosNuev);
    writeln('Casos recuperados: ', reg.cantCasosRec);
    writeln('Casos fallecidos: ', reg.cantCasosFall);
    writeln('----------------------------');
  end;
  
  close(mae);
end. 