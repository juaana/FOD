program CargarDetalle;
type
  logs_maquina = record
    cod_usuario: integer;
    fecha: string[8];       // formato 'DDMMYYYY'
    tiempo_sesion: integer; // en minutos, por ejemplo
  end;

  detalle = file of logs_maquina;

procedure cargarDetalle(var arch: detalle; nombre: string);
var
  reg: logs_maquina;
  opcion: char;
begin
  Assign(arch, nombre);
  Rewrite(arch);
  
  writeln('Cargando archivo: ', nombre);
  repeat
    write('Código de usuario: '); readln(reg.cod_usuario);
    write('Fecha (DDMMYYYY): '); readln(reg.fecha);
    write('Tiempo de sesión (minutos): '); readln(reg.tiempo_sesion);
    write(arch, reg);

    write('¿Deseás cargar otro registro? (s/n): ');
    readln(opcion);
  until (opcion <> 's') and (opcion <> 'S');

  Close(arch);
  writeln('Archivo ', nombre, ' cargado con éxito.');
end;

var
  d1, d2, d3: detalle;
begin
  cargarDetalle(d1, 'detalle1.dat');
  cargarDetalle(d2, 'detalle2.dat');
  cargarDetalle(d3, 'detalle3.dat');
end.
