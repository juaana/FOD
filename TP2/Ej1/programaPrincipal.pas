program CompactarComisiones;

type
    empleado = record
        codigo: integer;
        nombre: String[8];
        comision: real;
    end;

    archivoEmpleados = file of empleado;

procedure Compactar(var archivoComisiones, archivoCompacto: archivoEmpleados);
var
    e, empActual: empleado;
    codActual: integer;
    totalComision: real;
begin
    Reset(archivoComisiones);  
    Rewrite(archivoCompacto);  

    if not eof(archivoComisiones) then  
    begin
        Read(archivoComisiones, e);  

        while not eof(archivoComisiones) do
        begin
            codActual := e.codigo;
            totalComision := 0;
            
            
            empActual.codigo := codActual;
            empActual.nombre := e.nombre;
            empActual.comision := 0;

            
            while (not eof(archivoComisiones)) and (e.codigo = codActual) do
            begin
                totalComision := totalComision + e.comision;
                Read(archivoComisiones, e);  
            end;

            
            empActual.comision := totalComision;
            Write(archivoCompacto, empActual);
        end;
    end;

    Close(archivoComisiones);
    Close(archivoCompacto);
end;

var
    archivoComisiones, archivoCompacto: archivoEmpleados;
begin
    Assign(archivoComisiones, 'empleados.dat');   // Archivo original
    Assign(archivoCompacto, 'empleadosCompacto.dat');  // Archivo nuevo

    Compactar(archivoComisiones, archivoCompacto);

    Writeln('Archivo compactado correctamente.');
end.
