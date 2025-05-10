{
	Se cuenta con un archivo que posee información de las ventas que 
	realiza una empresa a los diferentes clientes. Se necesita obtener 
	un reporte con las ventas organizadas por cliente. Para ello, se 
	deberá informar por pantalla: 
	
	los datos personales del cliente, 
	el total mensual (mes por mes cuánto compró) 
	y finalmente el monto total comprado en el año por el cliente. 
	
	
	Además, al finalizar el reporte, se debe informar el monto total 
	de ventas obtenido por la empresa.
	
	El formato del archivo maestro está dado por: cliente (cod cliente, 
	nombre y apellido), año, mes, día y monto de la venta. El orden del 
	archivo está dado por: cod cliente, año y mes.
	
	Nota: tenga en cuenta que puede haber meses en los que los clientes 
	no realizaron compras. No es necesario que informe tales meses en el 
	reporte.
   
	
   
}


program EJ9TP2;
const valorAlto= 9999;
type
	cliente = record
		codCliente: integer;
		nombre: String[10];
		apellido: String[10];
	end;
	
	venta = record
		cliente : cliente;
		ano: integer;
		mes: integer;
		dia: integer;
		montoVenta: real;
	end;
	
	maestro= file of venta;

procedure leer(var archivo: maestro; var regM: venta);
begin
	if (not(EOF(archivo))) then
	begin
		read(archivo, regM);
	end
	else
		begin
			regM.cliente.codCliente:= valorAlto;
		end;
		
end;

procedure generarInforme(var aM: maestro);
var
	regM: venta;

	totalMes, totalAnual, totalEmpresa: real;
	cliente, mes, ano: integer;
begin
	reset(aM);
	leer(aM, regM);
	totalEmpresa:= 0;
	Writeln('=======');
	Writeln('Informe');
	Writeln('=======');
	while (regM.cliente.codCliente<>valorAlto) do
	begin
		cliente:= regM.cliente.codCliente;
		totalAnual:= 0;
		
		Writeln('Cliente: ', regM.cliente.nombre,' ',regM.cliente.apellido ,'. | Código de cliente: ', cliente);
		while(cliente = regM.cliente.codCliente) do
		begin
			ano:= regM.ano;
			while(cliente = regM.cliente.codCliente) AND (ano = regM.ano) do
			begin
				mes:=regM.mes;
				totalMes:=0;
				while(cliente = regM.cliente.codCliente) AND (ano = regM.ano) AND (mes = regM.mes) do
				begin
					totalMes:= totalMes + regM.montoVenta;
					leer(aM, regM);
				end;
				Writeln('Total del mes ', mes, '/' , ano, ': $', totalMes:0:2);
				totalAnual:= totalAnual+totalMes;	
			end;
			Writeln('Total del año ', ano, ': $', totalAnual:0:2); 
			Writeln('------------------------------------------');
			totalEmpresa:= totalEmpresa+totalAnual;
		end;
	end;
	Writeln('Total de la empresa: $', totalEmpresa:0:2); 
	Writeln('===============');
	Writeln('Fin del informe');
	Writeln('===============');
	close(aM);
end;
var
	aM: maestro;
BEGIN
	Assign(aM, 'ventas.dat');
	generarInforme(aM);
	
END.

