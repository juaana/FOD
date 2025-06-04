program EJ15TP2;
const 
	valorAlto = 9999;
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
	vectorReg = array[1..dimF] of viviendasParcial;

procedure leerD(var archivo: detalle; var data: viviendasParcial);
begin
	if not EOF(archivo) then
		read(archivo, data)
	else
		data.codProv := valorAlto;
end;

procedure leerM(var archivo: maestro; var data: viviendasTotal);
begin
	if not EOF(archivo) then
		read(archivo, data)
	else
		data.codProv := valorAlto;
end;

procedure minimo(var det: vectorDetalle; var regs: vectorReg; var min: viviendasParcial);
var
	i, pos: integer;
begin
	min.codProv := valorAlto;
	min.codLoc := valorAlto;
	for i := 1 to dimF do
	begin
		if (regs[i].codProv <= min.codProv) and (regs[i].codLoc < min.codLoc) then
		begin
			min := regs[i];
			pos := i;
		end;
	end;
	if min.codProv <> valorAlto then
		leerD(det[pos], regs[pos]);
end;

procedure merge(var mae: maestro; var det: vectorDetalle);
var
	regM: viviendasTotal;
	regsD: vectorReg;
	min: viviendasParcial;
	i: integer;

begin
	reset(mae);
	for i := 1 to dimF do
	begin
		reset(det[i]);
		leerD(det[i], regsD[i]);
	end;

	minimo(det, regsD, min);
	while min.codProv <> valorAlto do
	begin
		
		seek(mae, 0);
		leerM(mae, regM);
		while (regM.codProv <> valorAlto) and 
			((regM.codProv <> min.codProv) or (regM.codLoc <> min.codLoc)) do
		begin
			leerM(mae, regM);
		end;

		// Actualizar campos
		regM.viviendaSL := regM.viviendaSL - min.viviendaCL;
		regM.viviendaSG := regM.viviendaSG - min.viviendaCG;
		regM.viviendaSA := regM.viviendaSA - min.viviendaCA;
		regM.viviendaSS := regM.viviendaSS - min.entregaS;
		regM.viviendasCH := regM.viviendasCH - min.viviendaC;

		// Volver a escribir el registro en su lugar
		seek(mae, filePos(mae) - 1);
		write(mae, regM);

		minimo(det, regsD, min);
	end;

	

	close(mae);
	for i := 1 to dimF do
		close(det[i]);
end;

var
	mae: maestro;
	dets: vectorDetalle;
	
begin
	// Asignación de archivos
	assign(mae, 'maestro.dat');
	assign(dets[1], 'detalle1.dat');
	assign(dets[2], 'detalle2.dat');
	assign(dets[3], 'detalle3.dat');
	merge(mae, dets);
	
	
	
end.
