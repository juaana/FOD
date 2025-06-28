program CrearArchivosSemanarios;


type
  fechaStr = string[10];
  codigoSemanario = integer;

  regMaestro = record
    fecha: fechaStr;
    codigo: codigoSemanario;
    nombre: string[30];
    descripcion: string[100];
    precio: real;
    totalEjemplares: integer;
    totalVendidos: integer;
  end;

  regDetalle = record
    fecha: fechaStr;
    codigo: codigoSemanario;
    vendidos: integer;
  end;

  archivoMaestro = file of regMaestro;
  archivoDetalle = file of regDetalle;

var
  mae: archivoMaestro;
  det1, det2, det3: archivoDetalle;
  rm: regMaestro;
  rd: regDetalle;

begin
  { Crear y cargar archivo maestro }
  assign(mae, 'maestro.dat');
  rewrite(mae);

  rm.fecha := '20250601';
  rm.codigo := 101;
  rm.nombre := 'Revista Tech';
  rm.descripcion := 'Tecnología y gadgets';
  rm.precio := 150.0;
  rm.totalEjemplares := 100;
  rm.totalVendidos := 0;
  write(mae, rm);

  rm.codigo := 102;
  rm.nombre := 'Cocina Feliz';
  rm.descripcion := 'Recetas y tips de cocina';
  rm.precio := 120.0;
  write(mae, rm);

  rm.codigo := 103;
  rm.nombre := 'Fitness Hoy';
  rm.descripcion := 'Salud y ejercicios';
  rm.precio := 130.0;
  write(mae, rm);

  close(mae);

  { Crear y cargar archivo detalle 1 }
  assign(det1, 'detalle1.dat');
  rewrite(det1);

  rd.fecha := '20250601';
  rd.codigo := 101;
  rd.vendidos := 20;
  write(det1, rd);

  rd.codigo := 102;
  rd.vendidos := 15;
  write(det1, rd);

  close(det1);

  { Crear y cargar archivo detalle 2 }
  assign(det2, 'detalle2.dat');
  rewrite(det2);

  rd.fecha := '20250601';
  rd.codigo := 101;
  rd.vendidos := 30;
  write(det2, rd);

  rd.codigo := 103;
  rd.vendidos := 10;
  write(det2, rd);

  close(det2);

  { Crear y cargar archivo detalle 3 }
  assign(det3, 'detalle3.dat');
  rewrite(det3);

  rd.fecha := '20250601';
  rd.codigo := 102;
  rd.vendidos := 25;
  write(det3, rd);

  rd.codigo := 103;
  rd.vendidos := 20;
  write(det3, rd);

  close(det3);

  writeln('Archivos creados con éxito.');
end.
