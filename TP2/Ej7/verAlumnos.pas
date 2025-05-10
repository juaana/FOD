program VerAlumnos;
type
  alumno = record
    codAlumno: integer;
    apellido: String[10];
    nombre: String[10];
    cantCursadasAprobadas: integer;
    cantFinalesAprobados: integer;
  end;

  maestro = file of alumno;

var
  arch: maestro;
  reg: alumno;

begin
  Assign(arch, 'alumnos.dat');
  Reset(arch);
  writeln('Listado de alumnos:');
  writeln('-------------------');
  while not EOF(arch) do
  begin
    read(arch, reg);
    writeln('Codigo: ', reg.codAlumno);
    writeln('Apellido: ', reg.apellido);
    writeln('Nombre: ', reg.nombre);
    writeln('Cursadas aprobadas: ', reg.cantCursadasAprobadas);
    writeln('Finales aprobados: ', reg.cantFinalesAprobados);
    writeln('-------------------');
  end;
  Close(arch);
end.

