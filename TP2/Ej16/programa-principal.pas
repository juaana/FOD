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


procedure actualizarMaestro(var m: maestro; var vectorDetalle: vecDetalle);
var
  i, codMax, codMin, max, min: integer;
  fechaMax, fechaMin: String[10];
  vectorRegistros: vecInfo;
  minD: semanarioRegion;
  regM: emisionSemanario;
  totalVentas:integer;
begin
    max:= -1;
    codMax:= 0;
    fechaMax:= '';
    min:= 9999;
    codMin:= 0;
    fechaMin:= '';
    reset(m);
    for i:= 1 to dimF do
        begin
            reset(vectorDetalle[i]);
            leer(vectorDetalle[i], vectorRegistros[i]);
        end;
    minimo(vectorDetalle, vectorRegistros, minD);
    read(m, regM);
    while(minD.fecha <> VA) do
        begin
            while(minD.fecha <> regM.fecha) do
                read(m, regM);
            while (NOT(EOF(m))) AND (minD.fecha = regM.fecha) do
                begin
                    while(minD.codigo <> regM.codigo) do
                        read(m, regM);
                    totalVentas:= 0;
                    while (not (EOF(m))) AND (minD.fecha = regM.fecha) and (minD.codigo = regM.codigo) do
                        begin
                            if(regM.totalEjVendidos >= minD.cantEjVendidos) then
                                begin
                                    regM.totalEjVendidos:= regM.totalEjVendidos + minD.cantEjVendidos;
                                    regM.totalEj:= regM.totalEj - minD.cantEjVendidos;
                                    totalVentas:= totalVentas + minD.cantEjVendidos;
                                end;
                            minimo(vectorDetalle, vectorRegistros, minD);
                        end;
                    if(totalVentas > max) then
                        begin
                            max:= totalVentas;
                            fechaMax:= regM.fecha;
                            codMax:= regM.codigo;
                        end;
                    if(totalVentas < min) then
                        begin
                            min:= totalVentas;
                            fechaMin:= regM.fecha;
                            codMin:= regM.codigo;
                        end;
                    seek(m, filepos(m)-1);
                    write(m, regM);
                end;    
        end;
    writeln('Semanario con mas ventas: Fecha=', fechaMax, ' Codigo=', codMax);
    writeln('Semanario con menos ventas: Fecha=', fechaMin, ' Codigo=', codMin);
    close(m);
    for i:= 1 to dimF do
        close(vectorDetalle[i]);
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

