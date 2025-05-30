program GenerarArchivos;

const
  CANT_CATEGORIAS = 15;

type
  empleado = record
    depto: integer;
    division: integer;
    numEmp: integer;
    cat: integer;
    cantHsExtra: integer;
  end;

  archivoEmpleados = file of empleado;

var
  archivoPrecios: text;
  archivoEmpleadosDat: archivoEmpleados;
  precios: array[1..CANT_CATEGORIAS] of real = (
    50.0, 55.5, 60.0, 65.5, 70.0,
    75.5, 80.0, 85.5, 90.0, 95.5,
    100.0, 105.5, 110.0, 115.5, 120.0
  );
  e: empleado;
  i: integer;

procedure escribirEmpleado(depto, division, numEmp, cat, cantHsExtra: integer);
begin
  e.depto := depto;
  e.division := division;
  e.numEmp := numEmp;
  e.cat := cat;
  e.cantHsExtra := cantHsExtra;
  write(archivoEmpleadosDat, e);
end;

begin
  { Generar archivo de precios.txt }
  assign(archivoPrecios, 'precios.txt');
  rewrite(archivoPrecios);
  for i := 1 to CANT_CATEGORIAS do
    writeln(archivoPrecios, precios[i]:0:1);  
  close(archivoPrecios);
  writeln('Archivo "precios.txt" generado.');

  { Generar archivo binario empleados.dat }
  assign(archivoEmpleadosDat, 'empleados.dat');
  rewrite(archivoEmpleadosDat);



  // Departamento 1, División 1
  escribirEmpleado(1, 1, 101, 3, 10);
  escribirEmpleado(1, 1, 102, 2, 8);

  // Departamento 1, División 2
  escribirEmpleado(1, 2, 201, 1, 12);
  escribirEmpleado(1, 2, 202, 4, 7);

  // Departamento 2, División 1
  escribirEmpleado(2, 1, 301, 6, 6);
  escribirEmpleado(2, 1, 302, 2, 9);
  escribirEmpleado(2, 1, 302, 2, 4);

  // Departamento 2, División 2
  escribirEmpleado(2, 2, 401, 10, 3);

  close(archivoEmpleadosDat);
  writeln('Archivo binario "empleados.dat" generado.');
end.
