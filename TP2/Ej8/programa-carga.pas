program SimularCargaMaestroYDetalles;

type
  provincia = record
    codigoProv: integer;
    nombre: string[20];
    cantHabit: integer;
    cantTotalKg: real;
  end;

  consumoYerba = record
    codigoProv: integer;
    cantKg: real;
  end;

  maestro = file of provincia;
  detalle = file of consumoYerba;

var
  archMaestro: maestro;
  detalle0, detalle1: detalle;
  regM: provincia;
  regD: consumoYerba;

procedure simularCargaMaestro;
begin
  Assign(archMaestro, 'maestro.dat');
  Rewrite(archMaestro);

  // Provincia 1
  regM.codigoProv := 1;
  regM.nombre := 'Buenos Aires';
  regM.cantHabit := 1000;
  regM.cantTotalKg := 800;
  write(archMaestro, regM);

  // Provincia 2
  regM.codigoProv := 2;
  regM.nombre := 'Cordoba';
  regM.cantHabit := 500;
  regM.cantTotalKg := 9500;
  write(archMaestro, regM);

  // Provincia 3
  regM.codigoProv := 3;
  regM.nombre := 'Mendoza';
  regM.cantHabit := 3000;
  regM.cantTotalKg := 120;
  write(archMaestro, regM);

  Close(archMaestro);
end;

procedure simularCargaDetalle0;
begin
  Assign(detalle0, 'detalle0.dat');
  Rewrite(detalle0);

  // Provincia 1 aparece dos veces
  regD.codigoProv := 1;
  regD.cantKg := 400;
  write(detalle0, regD);
  regD.codigoProv := 1;
  regD.cantKg := 600;
  write(detalle0, regD);

  // Provincia 3 una vez
  regD.codigoProv := 3;
  regD.cantKg := 500;
  write(detalle0, regD);

  Close(detalle0);
end;

procedure simularCargaDetalle1;
begin
  Assign(detalle1, 'detalle1.dat');
  Rewrite(detalle1);

  // Provincia 2 una vez
  regD.codigoProv := 2;
  regD.cantKg := 700;
  write(detalle1, regD);

  // Provincia 3 una vez
  regD.codigoProv := 3;
  regD.cantKg := 800;
  write(detalle1, regD);

  Close(detalle1);
end;

begin
  simularCargaMaestro;
  simularCargaDetalle0;
  simularCargaDetalle1;
  writeln('✅ Simulación de maestro.dat, detalle0.dat y detalle1.dat completada.');
end.
