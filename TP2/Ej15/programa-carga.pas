program CargarArchivos;
const
  dimF = 3;
type
  viviendasTotal = record
    codProv: integer;
    nombreProv: String[10];
    codLoc: integer;
    nombreLoc: String[10];
    viviendaSL: integer;
    viviendaSG: integer;
    viviendasCH: integer;
    viviendaSA: integer;
    viviendaSS: integer;
  end;

  viviendasParcial = record
    codProv: integer;
    codLoc: integer;
    viviendaCL: integer;
    viviendaC: integer;
    viviendaCA: integer;
    viviendaCG: integer;
    entregaS: integer;
  end;

  maestro = file of viviendasTotal;
  detalle = file of viviendasParcial;
  vectorDetalle = array[1..dimF] of detalle;

procedure cargarMaestro(var mae: maestro);
var
  reg: viviendasTotal;
begin
  assign(mae, 'maestro.dat');
  rewrite(mae);

  reg.codProv := 1; reg.nombreProv := 'BuenosAir';
  reg.codLoc := 101; reg.nombreLoc := 'La Plata';
  reg.viviendaSL := 10; reg.viviendaSG := 5;
  reg.viviendasCH := 4; reg.viviendaSA := 3; reg.viviendaSS := 2;
  write(mae, reg);

  reg.codProv := 1; reg.nombreProv := 'BuenosAir';
  reg.codLoc := 102; reg.nombreLoc := 'Moreno';
  reg.viviendaSL := 7; reg.viviendaSG := 6;
  reg.viviendasCH := 5; reg.viviendaSA := 2; reg.viviendaSS := 3;
  write(mae, reg);

  reg.codProv := 2; reg.nombreProv := 'Cordoba';
  reg.codLoc := 201; reg.nombreLoc := 'Capital';
  reg.viviendaSL := 8; reg.viviendaSG := 4;
  reg.viviendasCH := 6; reg.viviendaSA := 1; reg.viviendaSS := 4;
  write(mae, reg);

  close(mae);
end;

procedure cargarDetalle(var det: detalle; nombre: string);
var
  reg: viviendasParcial;
begin
  assign(det, nombre);
  rewrite(det);

  // Ejemplo con algunos datos por archivo
  if nombre = 'detalle1.dat' then
  begin
    reg.codProv := 1; reg.codLoc := 101;
    reg.viviendaCL := 2; reg.viviendaC := 1; reg.viviendaCA := 0;
    reg.viviendaCG := 1; reg.entregaS := 1;
    write(det, reg);
  end
  else if nombre = 'detalle2.dat' then
  begin
    reg.codProv := 1; reg.codLoc := 102;
    reg.viviendaCL := 1; reg.viviendaC := 1; reg.viviendaCA := 1;
    reg.viviendaCG := 1; reg.entregaS := 1;
    write(det, reg);
  end
  else if nombre = 'detalle3.dat' then
  begin
    reg.codProv := 2; reg.codLoc := 201;
    reg.viviendaCL := 3; reg.viviendaC := 1; reg.viviendaCA := 1;
    reg.viviendaCG := 1; reg.entregaS := 2;
    write(det, reg);
  end;

  close(det);
end;

var
  mae: maestro;
  dets: vectorDetalle;
begin
  cargarMaestro(mae);
  cargarDetalle(dets[1], 'detalle1.dat');
  cargarDetalle(dets[2], 'detalle2.dat');
  cargarDetalle(dets[3], 'detalle3.dat');
  writeln('Archivos cargados correctamente.');
end.
