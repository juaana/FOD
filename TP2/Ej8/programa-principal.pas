{
Se quiere optimizar la gestión del consumo de yerba mate en distintas 
provincias de Argentina. Para ello, se cuenta con un archivo maestro 
que contiene la siguiente información: código de provincia, nombre de 
la provincia, cantidad de habitantes y cantidad total de kilos de yerba
consumidos históricamente.

Cada mes, se reciben 16 archivos de relevamiento con información sobre 
el consumo de yerba en los distintos puntos del país. Cada archivo 
contiene: código de provincia y cantidad de kilos de yerba consumidos en 
ese relevamiento.

Un archivo de relevamiento puede contener información 
de una o varias provincias, y una misma provincia puede aparecer cero, 
una o más veces en distintos archivos de relevamiento.
Tanto el archivo maestro como los archivos de relevamiento están 
ordenados por código de provincia.

Se desea realizar un programa que actualice el archivo maestro en base 
a la nueva información de consumo de yerba.

Además, se debe informar en pantalla aquellas provincias (código y nombre) 
donde la cantidad total de yerba consumida supere los 10.000 kilos
históricamente, junto con el promedio consumido de yerba por habitante.
Es importante tener en cuenta tanto las provincias actualizadas como las que no fueron actualizadas.
Nota: cada archivo debe recorrerse una única vez.
   
   
}


program EJ8TP2;
const 
    valorAlto = 9999;
    cantDetalles = 2;
type
    provincia = record
        codigoProv: integer;
        nombre: String[20];
        cantHabit: integer;
        cantTotalKg: real;
    end;
    
    consumoYerba = record
        codigoProv: integer;
        cantKg: real;
    end;
    
    maestro = file of provincia;
    detalle = file of consumoYerba;
    detallesArray = array[0..cantDetalles - 1] of detalle;
    registrosArray = array[0..cantDetalles - 1] of consumoYerba;

procedure leerMaestro(var archivo: maestro; var regM: provincia);
begin
    if (not EOF(archivo)) then
        read(archivo, regM)
    else
        regM.codigoProv := valorAlto;
end;

procedure leerDetalle(var archivo: detalle; var regD: consumoYerba);
begin
    if (not EOF(archivo)) then
        read(archivo, regD)
    else
        regD.codigoProv := valorAlto;
end;

procedure minimo(var v: registrosArray; var min: consumoYerba; var pos: integer);
var
    i: integer;
begin
    min.codigoProv := valorAlto;
    pos := -1;
    
    for i := 0 to cantDetalles - 1 do
    begin
        if (v[i].codigoProv < min.codigoProv) then
        begin
            min := v[i];
            pos := i;
        end;
    end;
end;

procedure actualizarMaestro(var aM: maestro; var aD: detallesArray);
var
    regM: provincia;
    regDet: registrosArray;
    min: consumoYerba;
    posMin: integer;
    i: integer;
    consumoTotal: real;
    prom: real;
begin
    reset(aM);
    for i := 0 to cantDetalles - 1 do
        reset(aD[i]);

    // Inicializar registros de detalle
    for i := 0 to cantDetalles - 1 do
        leerDetalle(aD[i], regDet[i]);

    leerMaestro(aM, regM);
    minimo(regDet, min, posMin);

    writeln('=== Informe de Consumo de Yerba por Provincia con consumo mayor a 10.000kg ===');

    while (regM.codigoProv <> valorAlto) do
    begin
        consumoTotal := 0;

        // Procesar todos los registros del mismo código de provincia
        while (min.codigoProv = regM.codigoProv) and (min.codigoProv <> valorAlto) do
        begin
            consumoTotal := consumoTotal + min.cantKg;
            leerDetalle(aD[posMin], regDet[posMin]);
            minimo(regDet, min, posMin);
        end;

        // Actualizar el registro maestro
        regM.cantTotalKg := regM.cantTotalKg + consumoTotal;
        seek(aM, filepos(aM) - 1);
        write(aM, regM);

        // Mostrar información de prov
        if (regM.cantHabit > 0) then
        begin
            
            if (regM.cantTotalKg > 10000) then
              begin
                prom := regM.cantTotalKg / regM.cantHabit;
				write('Provincia: ', regM.codigoProv, ' - ', regM.nombre);
				write(' | Consumo Total: ', regM.cantTotalKg:0:2, ' kg');
				write(' | Promedio por habitante: ', prom:0:2, ' kg');
              end;
           
        end;

        leerMaestro(aM, regM);
    end;

    writeln;
    writeln('=== Fin del Informe ===');

    // Cerrar archivos
    close(aM);
    for i := 0 to cantDetalles - 1 do
        close(aD[i]);
end;

var 
    detalles: detallesArray;
    mae: maestro;
    detalle0, detalle1: detalle;
BEGIN
    Assign(mae, 'maestro.dat');
    Assign(detalle0, 'detalle0.dat');
    Assign(detalle1, 'detalle1.dat');
    detalles[0] := detalle0;
    detalles[1] := detalle1;
    actualizarMaestro(mae, detalles);
END.
