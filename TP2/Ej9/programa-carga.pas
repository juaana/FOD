program CargarVentas;
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

    maestro = file of venta;

var
    archivo: maestro;
    reg: venta;

begin
    Assign(archivo, 'ventas.dat');
    Rewrite(archivo);

    // Cliente 1 - Juan Perez - Año 2024
    reg.cliente.codCliente := 1;
    reg.cliente.nombre := 'Juan';
    reg.cliente.apellido := 'Perez';

    reg.ano := 2024;
    reg.mes := 1;
    reg.dia := 10;
    reg.montoVenta := 1000.50;
    write(archivo, reg);

    reg.dia := 15;
    reg.montoVenta := 300.00;
    write(archivo, reg);

    reg.mes := 2;
    reg.dia := 5;
    reg.montoVenta := 980.00;
    write(archivo, reg);

    // Cliente 2 - Ana Torres - Año 2024
    reg.cliente.codCliente := 2;
    reg.cliente.nombre := 'Ana';
    reg.cliente.apellido := 'Torres';

    reg.ano := 2024;
    reg.mes := 3;
    reg.dia := 20;
    reg.montoVenta := 520.00;
    write(archivo, reg);

    // Cliente 1 - Juan Perez - Año 2025
    reg.cliente.codCliente := 1;
    reg.cliente.nombre := 'Juan';
    reg.cliente.apellido := 'Perez';

    reg.ano := 2025;
    reg.mes := 1;
    reg.dia := 3;
    reg.montoVenta := 750.00;
    write(archivo, reg);

    close(archivo);
    writeln('Archivo "ventas.dat" creado con éxito.');
end.
