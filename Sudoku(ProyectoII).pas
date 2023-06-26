program Proyectosudoku;

uses crt;
var opcion : integer;

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
	instrucciones;
	
END.

