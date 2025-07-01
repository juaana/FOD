program TP3EJ2;
const
  VA = 9999;
type
  mesa = record
    codigoLoc: integer;
    numeroMesa: integer;
    cantVotos: integer;
  end;
  mesas = file of mesa;

  recuentoMesas = record
    codigoLoc: integer;
    totalVotos: integer;
  end;
  recuento = file of recuentoMesas;

procedure leerR(var R: recuento; var dato: recuentoMesas);
begin
  if not EOF(R) then
    read(R, dato)
  else
    dato.codigoLoc := VA;
end;

function existeR(var R: recuento; cod: integer): integer;
var
  regR: recuentoMesas;
  pos: integer;
  encontrado: boolean;
begin
  encontrado := false;
  pos := -1;
  reset(R);
  while (not EOF(R)) and (not encontrado) do
  begin
    read(R, regR);
    if regR.codigoLoc = cod then
    begin
      encontrado := true;
      pos := FilePos(R) - 1;
    end;
  end;
  existeR := pos;
end;

procedure mergeArchivo(var R: recuento; var M: mesas);
var
  regM: mesa;
  regR: recuentoMesas;
  pos: integer;
begin
  reset(M);
  while (NOT(EOF(M))) do
  begin
    read(M, regM);
    pos := existeR(R, regM.codigoLoc);
    if pos <> -1 then
    begin
      seek(R, pos);
      read(R, regR);
      regR.totalVotos := regR.totalVotos + regM.cantVotos;
      seek(R, pos);
      write(R, regR);
    end
    else
    begin
      regR.codigoLoc := regM.codigoLoc;
      regR.totalVotos := regM.cantVotos;
      seek(R, FileSize(R));
      write(R, regR);
    end;
  end;
  close(M);
end;

procedure imprimir(var R: recuento);
var
  regR: recuentoMesas;
  totalGeneral: integer;
begin
  totalGeneral := 0;
  writeln('Código de Localidad   Total de Votos');
  writeln('---------------------  -------------');
  reset(R);
  while not EOF(R) do
  begin
    read(R, regR);
    totalGeneral := totalGeneral + regR.totalVotos;
    writeln(regR.codigoLoc:21, regR.totalVotos:15);
  end;
  writeln;
  writeln('Total General de Votos: ', totalGeneral:5);
  close(R);
end;

var
  M1, M2: mesas;
  R: recuento;
 
begin
  Assign(R, 'recuento.dat');
  Assign(M1, 'mesas1.dat');
  Assign(M2, 'mesas2.dat');

  mergeArchivo(R, M1);
  mergeArchivo(R, M2);


  imprimir(R);
end.
