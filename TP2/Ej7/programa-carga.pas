
program cargaEJ7TP2;


type
  alumno = record
    codAlumno: integer;
    apellido: string[10];
    nombre: string[10];
    cantCursadasAprobadas: integer;
    cantFinalesAprobados: integer;
  end;

  cursada = record
    codAlumno: integer;
    codMateria: integer;
    anoExamen: integer;
    resultado: string[12];
  end;

  finales = record
    codAlumno: integer;
    codMateria: integer;
    fechaExamen: string[10];
    notaFinal: real;
  end;

  maestro = file of alumno;
  detalleCursada = file of cursada;
  detalleFinal = file of finales;

var
  aM: maestro;
  aDC: detalleCursada;
  aDF: detalleFinal;

  regM: alumno;
  regC: cursada;
  regF: finales;

begin
  // Crear archivo maestro
  Assign(aM, 'alumnos.dat');
  Rewrite(aM);

  regM.codAlumno := 1;
  regM.apellido := 'Perez';
  regM.nombre := 'Juan';
  regM.cantCursadasAprobadas := 0;
  regM.cantFinalesAprobados := 0;
  write(aM, regM);

  regM.codAlumno := 2;
  regM.apellido := 'Gomez';
  regM.nombre := 'Ana';
  regM.cantCursadasAprobadas := 0;
  regM.cantFinalesAprobados := 0;
  write(aM, regM);

  Close(aM);

  // Crear archivo detalle de cursadas
  Assign(aDC, 'detalleCursadas.dat');
  Rewrite(aDC);

  regC.codAlumno := 1;
  regC.codMateria := 101;
  regC.anoExamen := 2023;
  regC.resultado := 'aprobado';
  write(aDC, regC);

  regC.codAlumno := 1;
  regC.codMateria := 102;
  regC.anoExamen := 2023;
  regC.resultado := 'desaprobado';
  write(aDC, regC);

  regC.codAlumno := 2;
  regC.codMateria := 103;
  regC.anoExamen := 2023;
  regC.resultado := 'aprobado';
  write(aDC, regC);

  Close(aDC);

  // Crear archivo detalle de finales
  Assign(aDF, 'detalleFinal.dat');
  Rewrite(aDF);

  regF.codAlumno := 1;
  regF.codMateria := 101;
  regF.fechaExamen := '2023-12-01';
  regF.notaFinal := 7.5;
  write(aDF, regF);

  regF.codAlumno := 2;
  regF.codMateria := 103;
  regF.fechaExamen := '2023-12-01';
  regF.notaFinal := 3.0;
  write(aDF, regF);

  regF.codAlumno := 2;
  regF.codMateria := 104;
  regF.fechaExamen := '2023-12-02';
  regF.notaFinal := 8.0;
  write(aDF, regF);

  Close(aDF);

  writeln('Archivos generados exitosamente.');
end.


