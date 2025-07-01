{
  La editorial X, autora de diversos semanarios, posee un archivo maestro
  con la información correspondiente a las diferentes emisiones de los mismos. 
  De cada emisión se registra: 
  -fecha, 
  -código de semanario, 
  -nombre del semanario, 
  -descripción, 
  -precio, 
  -total de ejemplares y 
  -total de ejemplares vendidos
  
  Mensualmente se reciben 100 archivos detalles con las ventas de los 
  semanarios en todo el país. La información que poseen los detalles es
  la siguiente: 
  -fecha,
  -código de semanario y 
  -cantidad de ejemplares vendidos. 
  
  Realice las declaraciones necesarias, la llamada al procedimiento y 
  el procedimiento que recibe el archivo maestro y los 100 detalles y 
  realice la actualización del archivo maestro en función de las ventas registradas.
  
  Además deberá informar fecha y semanario que tuvo más ventas y la 
  misma información del semanario con menos ventas.
   
  Nota: Todos los archivos están ordenados por fecha y código de semanario.
  No se realizan ventas de semanarios si no hay ejemplares para hacerlo
   
}


program TP2EJ16;

const
	VA= '9999-99-99';
	dimF= 3 ;
type
	
	subrango= 1..dimF;
	
	emisionSemanario = record
		fecha: String[10];
		codigo: integer;
		nombre: String[10];
		descripcion: String[20];
		precio: real;
		totalEj: integer;
		totalEjVendidos: integer;
	end;
	
	semanarioRegion = record
		fecha: String[10];
		codigo: integer;
		cantEjVendidos: integer;
		end;
	
	maestro= file of emisionSemanario;
	detalle= file of semanarioRegion;
	
	vecDetalle= array [subrango] of detalle;
	vecInfo= array [subrango] of semanarioRegion;

procedure leer(var archivo: detalle; var dato: semanarioRegion); 
begin
	if (NOT(EOF(archivo))) then
		read(archivo, dato)
	else
		dato.fecha:= VA;
		
end;

procedure minimo(var vectorDetalle: vecDetalle; var vectorRegistros: vecInfo; var min: semanarioRegion);
var
  i, pos: subrango;
  encontro: boolean;
begin
  min.fecha := VA;
  pos := 1;
  encontro := false;
  for i := 1 to dimF do
  begin
    if (vectorRegistros[i].fecha < min.fecha) OR
       ((vectorRegistros[i].fecha = min.fecha) AND (vectorRegistros[i].codigo < min.codigo)) then
    begin
      min := vectorRegistros[i];
      pos := i;
      encontro := true;
    end;
  end;
  if encontro then
    leer(vectorDetalle[pos], vectorRegistros[pos]);
end;


procedure actualizarMaestro(var m: maestro; var D: vecDetalle);
var
  regM: emisionSemanario;
  regs: vecInfo;
  minD: semanarioRegion;
  totalVentas, maxV, minV: integer;
  codMax, codMin: integer;
  fechaMax, fechaMin: string[10];
  i: integer;
begin
  // Inicializar máximos/mínimos
  maxV := -1;          minV := MaxInt;
  codMax := 0;         codMin := 0;
  fechaMax := '';      fechaMin := '';

  // Preparo maestro y detalles
  reset(m);
  for i := 1 to dimF do begin
    reset(D[i]);
    leer(D[i], regs[i]);
  end;

  // Traigo el primer mínimo global
  minimo(D, regs, minD);

  // Recorro todo el maestro
  while not EOF(m) do begin
    read(m, regM);

    // Si la fecha del maestro es menor al minD, avanzo maestro
    while (regM.fecha < minD.fecha) do
      if not EOF(m) then read(m, regM)
      else Break;

    // Si coincide fecha y código, acumulo:
    if (regM.fecha = minD.fecha) then begin
      totalVentas := 0;
      // Mientras el detalle aporte al mismo emisión
      while (minD.fecha = regM.fecha) and (minD.codigo = regM.codigo) do begin
        totalVentas += minD.cantEjVendidos;
        minimo(D, regs, minD);
      end;

      // Actualizo el maestro en disco
      regM.totalEjVendidos := regM.totalEjVendidos + totalVentas;
      regM.totalEj        := regM.totalEj - totalVentas;
      seek(m, FilePos(m)-1);
      write(m, regM);
      seek(m, FilePos(m));     // avanzo cursor de lectura

      // Ajusto máximos y mínimos
      if totalVentas > maxV then begin maxV := totalVentas; codMax := regM.codigo; fechaMax := regM.fecha; end;
      if (totalVentas < minV) and (totalVentas > 0) then begin minV := totalVentas; codMin := regM.codigo; fechaMin := regM.fecha; end;
    end;
  end;

  // Cierro todo
  close(m);
  for i := 1 to dimF do
    close(D[i]);

  // Informo
  writeln('Más ventas -> Fecha: ', fechaMax, '  Código: ', codMax, '  Cant: ', maxV);
  writeln('Menos ventas -> Fecha: ', fechaMin, '  Código: ', codMin, '  Cant: ', minV);
end;



var
	detalle1, detalle2, detalle3: detalle;
	m: maestro;
	vectorDetalle: vecDetalle;

BEGIN
	assign(m, 'maestro.dat');
	assign(detalle1, 'detalle1.dat');
	assign(detalle2, 'detalle2.dat');
	assign(detalle3, 'detalle3.dat');

		
	vectorDetalle[1]:= detalle1;
	vectorDetalle[2]:= detalle2;
	vectorDetalle[3]:= detalle3;
	
	actualizarMaestro(m, vectorDetalle);

	
END.

