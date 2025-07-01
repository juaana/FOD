program ProcesarLogs;
const
  VA_COD   = -1;
  VA_FECHA = '9999-99-99';
type
  maestroLog = record
    codUsuario: integer;
    fecha: string[10];
    tiempoTotal: integer;
  end;
  archivoMaestro = file of maestroLog;

  detalleLog = record
    codUsuario: integer;
    fecha: string[10];
    tiempoSesion: integer;
  end;
  archivoDetalle = file of detalleLog;

procedure leerD(var D: archivoDetalle; var regD: detalleLog);
begin
  if not EOF(D) then
    read(D, regD)
  else
  begin
    regD.codUsuario   := VA_COD;
    regD.fecha        := VA_FECHA;
    regD.tiempoSesion := 0;
  end;
end;

function existeM(var M: archivoMaestro; codigo: integer): integer;
var
  regM: maestroLog;
  pos: integer;
  ok: boolean;
begin
  ok := false;
  pos := -1;
  reset(M);
  while (not EOF(M)) and (not ok) do
  begin
    read(M, regM);
    if (regM.codUsuario = codigo)  then
    begin
      ok := true;
      pos := FilePos(M) - 1;
    end;
  end;
  existeM := pos;
end;

// Fusiona un archivo detalle en el maestro existente
procedure mergeArchivo(var M: archivoMaestro; var D: archivoDetalle);
var
  regD: detalleLog;
  regM: maestroLog;
  pos: integer;
begin
  reset(M);
  reset(D);
  leerD(D, regD);
  while (regD.codUsuario <> VA_COD) do
  begin
    pos := existeM(M, regD.codUsuario);
    if pos <> -1 then
    begin
      seek(M, pos);
      read(M, regM);
      regM.tiempoTotal := regM.tiempoTotal + regD.tiempoSesion;
      seek(M, pos);
      write(M, regM);
    end
    else
    begin
      regM.codUsuario  := regD.codUsuario;
      regM.fecha       := regD.fecha;
      regM.tiempoTotal := regD.tiempoSesion;
      seek(M, FileSize(M));
      write(M, regM);
    end;
    leerD(D, regD);
  end;
  close(D);
  close(M);
end;

procedure imprimirMaestro(var M: archivoMaestro);
var
  regM: maestroLog;
  totalGeneral: integer;
begin
  totalGeneral := 0;
  writeln('Cod Usuario  Fecha       Tiempo Total');
  writeln('-----------  ----------  ------------');
  reset(M);
  while not EOF(M) do
  begin
    read(M, regM);
    writeln(
      regM.codUsuario:11, '  ',
      regM.fecha:10,       '  ',
      regM.tiempoTotal:12
    );
    totalGeneral := totalGeneral + regM.tiempoTotal;
  end;
  writeln;
  writeln('Total General de Sesiones Abiertas: ', totalGeneral);
  close(M);
end;

var
  M: archivoMaestro;
  D1, D2, D3, D4, D5: archivoDetalle;
begin
  Assign(M, 'maestro.dat');

	Assign(D1, 'detalle1.dat');
	Assign(D2, 'detalle2.dat');
	Assign(D3, 'detalle3.dat');
	Assign(D4, 'detalle4.dat');
	Assign(D5, 'detalle5.dat');
	mergeArchivo(M, D1);
	mergeArchivo(M, D2);
	mergeArchivo(M, D3);
	mergeArchivo(M, D4);
	mergeArchivo(M, D5);

  imprimirMaestro(M);
end.
