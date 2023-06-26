program Proyectosudoku;

uses crt;
var 
opcionjuego,userage, opciondatos: integer; 
username, useremail:string [30]; 
userphone : string [11]; 


Procedure instrucciones;
Begin
	Writeln ('             Reglas para jugar sudoku           ');
	writeln ('================================================');
	writeln ('Regla 1: Hay que completar las casillas vacias  ');
	Writeln ('con un solo numero del 1 al 9.');
	writeln ('================================================');
	writeln ('Regla 2: En una misma fila no puede haber       '); 
	Writeln ('numeros repetidos.');
	writeln ('================================================');
	writeln ('Regla 3: En una misma columna no puede haber    ');
	Writeln ('numeros repetidos.');
	writeln ('================================================');
	writeln ('Regla 4: En una misma region (o recuadro de 3x3)');
	Writeln ('no puede haber numeros repetidos.');
	writeln ('================================================');
	writeln ('Regla 5: La solucion de un sudoku es unica.');
	writeln ('================================================');
End;


BEGIN
	Writeln ('      Bienvenido al juego de sudoku      ');
	Writeln ('Por favor ingrese sus datos para comenzar');
	Writeln ('-----------------------------------------');
	repeat 
		Writeln ('Por favor ingrese su nombre');
		Readln (username);
		Writeln ('Por favor ingrese su edad');
		Readln (userage);
		Writeln ('Por favor ingrese su direccion de correo electronico');
		Readln (useremail);
		Writeln ('Por favor ingrese su numero telefonico');
		Readln (userphone);
		clrscr;
		writeln ('Los datos ingresados son:');
		Writeln ('Nombre: ', username);
		writeln ('Edad: ', userage);
		writeln ('Correo: ', useremail);
		writeln ('Telefono: ', userphone);
		Writeln ();
		writeln ('Los datos son correctos?');
		writeln ('En caso de que Si, teclee 1');
		Writeln ('En caso de que No, teclee 2 para editarlos');
		Readln (opciondatos);
	until opciondatos = 1;
	clrscr;
	Writeln ('Bienvenid@ ', username);
	writeln ('Indique su opcion');
	writeln ('=================');
	writeln ('1 = Jugar');
	Writeln ('2 = Mostrar reglas');
	Writeln ('3 = Salir');
	Readln (opcionjuego);
		case opcionjuego of 
			1: begin
			end;
			2: begin
			instrucciones;
			end;
			3: begin
			end;
		end;
END.

