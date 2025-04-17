{
   Suponga que trabaja en una oficina donde está montada una LAN (red local). 
   
   La misma fue construida sobre una topología de red que conecta 5 máquinas entre sí y 
   todas las máquinas se conectan con un servidor central. 
   
   Semanalmente cada máquina genera un archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y
   por cuánto tiempo estuvo abierta. 
   Cada archivo detalle contiene los siguientes campos: cod_usuario, fecha, tiempo_sesion. 
   
   Debe realizar un procedimiento que reciba los archivos detalle y genere un archivo maestro con los siguientes datos:
   cod_usuario, fecha, tiempo_total_de_sesiones_abiertas.
   
   Notas:
   ● Cada archivo detalle está ordenado por cod_usuario y fecha.
   ● Un usuario puede iniciar más de una sesión el mismo día en la misma máquina, o inclusive, en diferentes máquinas.
   ● El archivo maestro debe crearse en la siguiente ubicación física: /var/log.
   
}

program Ej5TP2;
const
	valoralto=9999;
type
	
	logs_maquina = record
		cod_usuario: integer;
		fecha: String[8];
		tiempo_sesion: integer;
	end;
	
	maestro = file of logs_maquina;
	detalle= file of logs_maquina;

procedure leer(var archivo: detalle; var regD: logs_maquina);
begin
	if (not(EOF(archivo))) then
		read(archivo, regD)
	else
		regD.cod_usuario:= valoralto
end;
procedure minimo(var aD1,aD2,aD3: detalle; var regD1, regD2, regD3, min: logs_maquina);
begin
	if(regD1.cod_usuario <= regD2.cod_usuario) and (regD1.cod_usuario<=regD3.cod_usuario) then
	begin
		min:= regD1;
		leer(aD1, regD1);
	end
	else
		if(regD2.cod_usuario <= regD3.cod_usuario) then
		begin
			min:=regD2;
			leer(aD2, regD2);
		end
		else
			begin
				min:= regD3;
				leer(aD1, regD3);
			end
end;

procedure merge(var aM: maestro; var aD1, aD2, aD3: detalle);
var
	regD1, regD2, regD3, aux, min: logs_maquina;
	total: integer;
begin
	total:= 0;
	Rewrite(aM);
	Reset(aD1);
	Reset(aD2);
	Reset(aD3);
	leer(aD1, regD1);
	leer(aD2, regD2);
	leer(aD3, regD3);
	minimo(aD1, aD2, aD3, regD1, regD2, regD3, min);
	while(min.cod_usuario <> valoralto) do
	begin
		aux:= min;
		total:=0;
		while(min.cod_usuario = aux.cod_usuario) do
		begin
			total:= total + min.tiempo_sesion;
			minimo(aD1, aD2, aD3, regD1, regD2, regD3, min);
		end;
		aux.tiempo_sesion:= total;
		write(aM, aux);
	end;
	close(aM);
	close(aD1);
	close(aD2);
	close(aD3);
end;

procedure mostrar(var aM: maestro);
var
	regM: logs_maquina;
begin
	reset(aM);
	while (not(EOF(aM))) do
	begin
		read(aM, regM);
		writeln('Código de usuario: ', regM.cod_usuario);
		writeln('Fecha: ', regM.fecha);
		writeln('Tiempo total de sesion (seg): ', regM.tiempo_sesion);
	end;
	close(aM);
end;
var
	aM: maestro;
	aD1, aD2, aD3: detalle;
	
BEGIN
	Assign(aM, 'maestro.dat');
	Assign(aD1, 'detalle1.dat');
	Assign(aD2, 'detalle2.dat');
	Assign(aD3, 'detalle3.dat');
	merge(aM, aD1, aD2, aD3);
	mostrar(aM);
END.

