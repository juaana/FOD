{
   Realizar un programa que genere un archivo de novelas
   filmadas durante el presente año. De cada novela se registra: 
   código, género, nombre, duración, director y precio.
    El programa debe presentar un menú con las siguientes opciones:
    
   a. Crear el archivo y cargarlo a partir de datos ingresados por teclado. 
   Se utiliza la técnica de lista invertida para recuperar espacio libre 
   en el archivo. Para ello, durante la creación del archivo, en el primer 
   registro del mismo se debe almacenar la cabecera de la lista. 
   Es decir un registro ficticio, inicializando con el valor cero (0) el 
   campo correspondiente al código de novela, el cual indica que no hay 
   espacio libre dentro del archivo.
   
}


program TP3EJ3;

type 

	novela = record
		codigo: integer;
		genero: String[10];
		nombre: String[10];
		duracion: real;
		director: String[10];
		precio: real;
	end;
	
	archivoNovelas = file of novela;
	
procedure crearArchivo(var A: archivoNovelas);
var
  nov: novela;
  continuar: char;
begin
  rewrite(A);
  // Cabecera: si codigo = 0 => no hay espacio libre
  nov.codigo := 0;
  write(A, nov); // posición 0
  continuar:= 's';
  while (continuar = 's') do
  begin
    writeln('Ingrese código:'); readln(nov.codigo);
    writeln('Ingrese nombre:'); readln(nov.nombre);
    writeln('Ingrese género:'); readln(nov.genero);
    writeln('Ingrese duración:'); readln(nov.duracion);
    writeln('Ingrese director:'); readln(nov.director);
    writeln('Ingrese precio:'); readln(nov.precio);  
    write(A, nov);
    
    writeln('¿Desea ingresar otra novela? (s/n)'); 
    readln(continuar);
  end;
  
  close(A);
end;

var
	A: archivoNovelas;
BEGIN
	Assign(A, 'novelas.dat');
	crearArchivo(A);
	
END.

