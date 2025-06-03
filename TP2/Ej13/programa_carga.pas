program CargarDatosHardcodeados;

type
  log = record
    nroUsuario: integer;
    nombreUsuario: String[10];
    nombre: String[10];
    apellido: String[10];
    cantidadMailsEnviados: integer;
  end;

  exp = record
    nroUsuario: integer;
    cuentaDestino: String[10];
    cuerpoMensaje: String[20];
  end;

  archivoLogs = file of log;
  archivoExp = file of exp;

var
  archivoL: archivoLogs;
  archivoE: archivoExp;

procedure cargarLogs(var archivoL: archivoLogs);
var
  logsHardcodeados: array[1..3] of log = (
    (nroUsuario: 1; nombreUsuario: 'juan123'; nombre: 'Juan'; apellido: 'Perez'; cantidadMailsEnviados: 10),
    (nroUsuario: 2; nombreUsuario: 'ana456'; nombre: 'Ana'; apellido: 'Gomez'; cantidadMailsEnviados: 5),
    (nroUsuario: 3; nombreUsuario: 'luis789'; nombre: 'Luis'; apellido: 'Lopez'; cantidadMailsEnviados: 0)
  );
  i: integer;
begin
  rewrite(archivoL);
  for i := 1 to 3 do
    write(archivoL, logsHardcodeados[i]);
  close(archivoL);
end;

procedure cargarExp(var archivoE: archivoExp);
var
  expHardcodeados: array[1..5] of exp = (
    (nroUsuario: 1; cuentaDestino: 'ana456'; cuerpoMensaje: 'Hola Ana'),
    (nroUsuario: 1; cuentaDestino: 'luis789'; cuerpoMensaje: 'Hola Luis'),
    (nroUsuario: 2; cuentaDestino: 'juan123'; cuerpoMensaje: 'Hola Juan'),
    (nroUsuario: 2; cuentaDestino: 'luis789'; cuerpoMensaje: 'Hola Luis'),
    (nroUsuario: 3; cuentaDestino: 'juan123'; cuerpoMensaje: 'Saludos Juan')
  );
  i: integer;
begin
  rewrite(archivoE);
  for i := 1 to 5 do
    write(archivoE, expHardcodeados[i]);
  close(archivoE);
end;

begin
  assign(archivoL, 'logmail.dat');
  assign(archivoE, 'expedientes.dat');

  cargarLogs(archivoL);
  cargarExp(archivoE);

  writeln('Datos cargados correctamente en los archivos.');
end.
