program CrearArchivoAccesos;

type
  acceso = record
    anio: integer;
    mes: integer;
    dia: integer;
    idUsuario: integer;
    tiempo: real;
  end;

  archivoAccesos = file of acceso;

var
  archivo: archivoAccesos;
  a: acceso;

procedure agregarAcceso(anio, mes, dia, id: integer; tiempo: real);
begin
  a.anio := anio;
  a.mes := mes;
  a.dia := dia;
  a.idUsuario := id;
  a.tiempo := tiempo;
  write(archivo, a);
end;

begin
  assign(archivo, 'archivoAccesos.dat');
  rewrite(archivo);

  // Año 2022 (no se debe encontrar si consultás 2023)
  agregarAcceso(2022, 12, 30, 101, 12.5);
  agregarAcceso(2022, 12, 30, 102, 30.0);

  // Año 2023
  agregarAcceso(2023, 3, 15, 101, 45.5);
  agregarAcceso(2023, 3, 15, 101, 10.0);
  agregarAcceso(2023, 3, 15, 104, 32.0);
  agregarAcceso(2023, 3, 16, 101, 5.0);
  agregarAcceso(2023, 4, 1, 102, 12.0);

  // Año 2024
  agregarAcceso(2024, 1, 1, 201, 25.0);
  agregarAcceso(2024, 1, 1, 201, 15.0);
  agregarAcceso(2024, 2, 2, 203, 40.0);

  close(archivo);
  writeln('Archivo "archivoAccesos.dat" creado con éxito.');
end.
