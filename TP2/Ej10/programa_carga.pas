program CargarMesas;

type
	mesa = record
		codProv: integer;
		codLoc: integer;
		numMesa: integer;
		cantidadVotos: integer;
	end;

	archivoMesa = file of mesa;

var
	arch: archivoMesa;
	reg: mesa;
	i: integer;

const
	datos: array[1..8] of mesa = (
		(codProv: 1; codLoc: 10; numMesa: 101; cantidadVotos: 50),
		( codProv: 1; codLoc: 10; numMesa: 102; cantidadVotos: 40),
		( codProv: 1; codLoc: 11; numMesa: 201; cantidadVotos: 60),
		( codProv: 1; codLoc: 11; numMesa: 202; cantidadVotos: 55),
		( codProv: 2; codLoc: 20; numMesa: 301; cantidadVotos: 80),
		( codProv: 2; codLoc: 20; numMesa: 302; cantidadVotos: 70),
		( codProv: 2; codLoc: 21; numMesa: 401; cantidadVotos: 65),
		( codProv: 2; codLoc: 21; numMesa: 402; cantidadVotos: 75)
	);

begin
	Assign(arch, 'mesas.dat');
	rewrite(arch);

	for i := 1 to Length(datos) do
	begin
		reg.codProv := datos[i].codProv;
		reg.codLoc := datos[i].codLoc;
		reg.numMesa := datos[i].numMesa;
		reg.cantidadVotos := datos[i].cantidadVotos;
		write(arch, reg);
	end;

	close(arch);
	writeln('Archivo mesas.dat creado.');
end.
