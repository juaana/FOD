program CargaArchivosHardcoded;

type
  vuelo = record
    destino: string[10];
    fecha: integer;          // Ejemplo: 25601
    hora: integer;
    cantidadAsientos: integer;
  end;

  arch = file of vuelo;

var
  maestro, detalle1, detalle2: arch;

procedure cargarMaestro(var arc: arch);
var
  vuelos: array[1..5] of vuelo = (
    (destino: 'Miami'; fecha: 25601; hora: 1000; cantidadAsientos: 120),
    (destino: 'Miami'; fecha: 25601; hora: 1500; cantidadAsientos: 100),
    (destino: 'Paris'; fecha: 25602; hora: 900;  cantidadAsientos: 80),
    (destino: 'Paris'; fecha: 25602; hora: 1300; cantidadAsientos: 75),
    (destino: 'Roma';  fecha: 25603; hora: 1100; cantidadAsientos: 60)
  );
  i: integer;
begin
  rewrite(arc);
  for i := 1 to 5 do
    write(arc, vuelos[i]);
  close(arc);
end;

procedure cargarDetalle1(var arc: arch);
var
  detalles: array[1..3] of vuelo = (
    (destino: 'Miami'; fecha: 25601; hora: 1000; cantidadAsientos: 10),
    (destino: 'Paris'; fecha: 25602; hora: 1300; cantidadAsientos: 5),
    (destino: 'Roma';  fecha: 25603; hora: 1100; cantidadAsientos: 2)
  );
  i: integer;
begin
  rewrite(arc);
  for i := 1 to 3 do
    write(arc, detalles[i]);
  close(arc);
end;

procedure cargarDetalle2(var arc: arch);
var
  detalles: array[1..3] of vuelo = (
    (destino: 'Miami'; fecha: 25601; hora: 1500; cantidadAsientos: 7),
    (destino: 'Paris'; fecha: 25602; hora: 900;  cantidadAsientos: 4),
    (destino: 'Roma';  fecha: 25603; hora: 1100; cantidadAsientos: 3)
  );
  i: integer;
begin
  rewrite(arc);
  for i := 1 to 3 do
    write(arc, detalles[i]);
  close(arc);
end;

begin
  assign(maestro, 'maestro.dat');
  assign(detalle1, 'detalle1.dat');
  assign(detalle2, 'detalle2.dat');

  writeln('Creando archivo maestro...');
  cargarMaestro(maestro);
  writeln('Archivo maestro creado.');

  writeln('Creando archivo detalle1...');
  cargarDetalle1(detalle1);
  writeln('Archivo detalle1 creado.');

  writeln('Creando archivo detalle2...');
  cargarDetalle2(detalle2);
  writeln('Archivo detalle2 creado.');
end.
