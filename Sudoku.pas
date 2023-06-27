program Proyectosudoku;

uses SysUtils, crt;

type
TTableroSudoku = array[1..9, 1..9] of Integer;
// Definición del tipo TTableroSudoku, que representa el tablero de Sudoku

var
Sudoku: TTableroSudoku;
//sudoku ahora sera una variable global que almacena el table de sudoku.
opcionjuego,userage, opciondatos: integer; 
username, useremail:string [30]; 
userphone : string [11]; 

procedure ImprimirSudoku(const Sudoku: TTableroSudoku);
var
i, j: Integer;
begin
    for i := 1 to 9 do
    begin
    if (i = 1) or (i mod 3 = 1) then
        Writeln('-----------------------');

    for j := 1 to 9 do
    begin
    if (j = 1) or (j mod 3 = 1) then
        Write('| ');

    if Sudoku[i, j] = 0 then
        Write('  ')
    else
        Write(Sudoku[i, j], ' ');
    end;
    Writeln;
    end;
end;
{Es un procedimiento que se encarga de imprimir el tablero de Sudoku en la consola.
Itera a través de las filas y columnas del tablero y muestra los números correspondientes.
También agrega líneas horizontales y verticales para separar las regiones del Sudoku.}

function EsNumeroValido(const Sudoku: TTableroSudoku; Fila, Columna, Numero: Integer): Boolean;
var
    i, j, InicioFila, InicioColumna: Integer;
begin
    for i := 1 to 9 do
    begin
    if (Sudoku[Fila, i] = Numero) or (Sudoku[i, Columna] = Numero) then
        Exit(False);
    end;

  InicioFila := ((Fila - 1) div 3) * 3 + 1;
  InicioColumna := ((Columna - 1) div 3) * 3 + 1;

    for i := InicioFila to InicioFila + 2 do
    begin
    for j := InicioColumna to InicioColumna + 2 do
    begin
        if Sudoku[i, j] = Numero then
        Exit(False);
        end;
    end;

Exit(True);
end;
{Es una función que verifica si un número se puede colocar en una posición específica del tablero de Sudoku sin violar las reglas del juego.
Comprueba si el número ya existe en la misma fila, columna o región del tablero.}

procedure GenerarPistasSudoku(var Sudoku: TTableroSudoku; Pistas: Integer);
var
    Fila, Columna, Numero, PistasGeneradas: Integer;
begin
    Randomize;

    for Fila := 1 to 9 do
    begin
    for Columna := 1 to 9 do
        Sudoku[Fila, Columna] := 0;
    end;

    PistasGeneradas := 0;
    while PistasGeneradas < Pistas do
    begin
    Fila := Random(9) + 1;
    Columna := Random(9) + 1;
    Numero := Random(9) + 1;

    if Sudoku[Fila, Columna] = 0 then
    begin
        if EsNumeroValido(Sudoku, Fila, Columna, Numero) then
        begin
        Sudoku[Fila, Columna] := Numero;
        Inc(PistasGeneradas);
            end;
        end;
    end;
end;
{Es un procedimiento que genera las pistas (números iniciales) en el tablero de Sudoku.
Utiliza el generador de números aleatorios para seleccionar filas, columnas y números aleatorios, y luego verifica si es válido colocar el número en esa posición.
Repite este proceso hasta generar el número deseado de pistas. (en este caso, se generan 17 pistas declaradas cuando se llama al procedimiento GenerarPistasSudoku)}

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
    clrscr;
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
			    clrscr;
			    GenerarPistasSudoku(Sudoku, 17);
				ImprimirSudoku(Sudoku);
			end; 
			2: begin
			instrucciones;
			end;
			3: begin
			end;
		end;
END.

