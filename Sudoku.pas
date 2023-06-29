program Proyectosudoku;

uses SysUtils, crt, DateUtils;

type
TTableroSudoku = array[1..9, 1..9] of Integer;
// Definición del tipo TTableroSudoku, que representa el tablero de Sudoku

var
Sudoku: TTableroSudoku;
//sudoku ahora sera una variable global que almacena el table de sudoku.
opcionjuego,opcion, userage, opciondatos: integer; 
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

{De una manera explicada mas a lo conveccional, el algoritmo backtracking va probando celda por celda (vacias) numeros para completar el sudoku
esto partiendo de las reglas de no repetirse numeros en la columnas, filas o el cuadrante 3x3
El algoritmo continúa probando diferentes números en las celdas vacías hasta que encuentra una solución completa
o hasta que se hayan probado todas las combinaciones posibles.
Si se encuentra una solucion completa para el sudoku, se devuelve el valor de true y si no se encuentra una solucion con todas las combinaciones posibles
Devuelve el valor de false.
Ademas que si en algún punto no se puede colocar ningún número válido en una celda vacía, se realiza una retrotracción (backtrack).
Esto implica volver a la celda anterior y probar con un número diferente.}
function ResolverSudoku(var Sudoku: TTableroSudoku): Boolean;
var
    Fila, Columna, Numero: Integer;
begin
    for Fila := 1 to 9 do
    begin
    for Columna := 1 to 9 do
    begin
        if Sudoku[Fila, Columna] = 0 then
        begin
        for Numero := 1 to 9 do
        begin
            if EsNumeroValido(Sudoku, Fila, Columna, Numero) then
            begin
            Sudoku[Fila, Columna] := Numero;
            if ResolverSudoku(Sudoku) then
                Exit(True);
            Sudoku[Fila, Columna] := 0;
            end;
        end;
        Exit(False);
        end;
    end;
    end;
Exit(True);
end;
{Es un procedimiento que genera las pistas (números iniciales) en el tablero de Sudoku.
Basicamente las pistas se crean  apartir de un sudoku generado perfecto, el cual se crea con un algoritmo de backtracking
Luego en un Array se localizan las posiciones de las pistas y se procede a mezclarse aleatoriamente con un ciclo for.
luego las posiciones de las pistas se intercambian por las pistas del sudoku antes generado, y para finalizar se eliminan
las pistas para llegar al numero de pistas deseado}
procedure GenerarPistasSudoku(var Sudoku: TTableroSudoku; Pistas: Integer);
var
    Fila, Columna, Numero, PistasEliminadas, TotalPistas: Integer;
    PistasAleatorias: array[1..81] of Integer; // Array para almacenar las pistas en orden aleatorio
    i: Integer;
begin
  // Generar un sudoku perfecto utilizando el algoritmo de backtracking
    ResolverSudoku(Sudoku);
    TotalPistas := 81;
    PistasEliminadas := 0;
  // Crear un array con todas las posiciones de las pistas
    for Fila := 1 to 9 do
    begin
    for Columna := 1 to 9 do
    begin
      PistasAleatorias[PistasEliminadas + 1] := (Fila - 1) * 9 + Columna;
        PistasEliminadas := PistasEliminadas + 1;
    end;
    end;
  // Mezclar aleatoriamente las posiciones de las pistas
    for i := TotalPistas downto 2 do
    begin
    Fila := Random(i) + 1;
    Columna := Random(i) + 1;
    // Intercambiar las posiciones de las pistas
    Numero := PistasAleatorias[i];
    PistasAleatorias[i] := PistasAleatorias[Fila];
    PistasAleatorias[Fila] := Numero;
    end;
  // Eliminar pistas hasta alcanzar el número deseado
    for i := 1 to PistasEliminadas - Pistas do
    begin
    Fila := (PistasAleatorias[i] - 1) div 9 + 1;
    Columna := (PistasAleatorias[i] - 1) mod 9 + 1;
    Sudoku[Fila, Columna] := 0;
    end;
end;

{se encarga de solicitar al usuario que ingrese una fila, columna y número para colocar en una celda del Sudoku
Una vez obtenido la fila, la columna y el numero, se procede a validar con la funcion esNumeroValido y si es true, se ingresa en el Array del tablero.}
procedure IngresarNumero(var Sudoku: TTableroSudoku);
var
    Fila, Columna, Numero: Integer;
begin
    ImprimirSudoku(Sudoku);
    Write('Ingresa la fila (1-9): ');
    ReadLn(Fila);
    Write('Ingresa la columna (1-9): ');
    ReadLn(Columna);
    Write('Ingresa el numero (1-9): ');
    ReadLn(Numero);

    if EsNumeroValido(Sudoku, Fila, Columna, Numero) then
    begin
    Sudoku[Fila, Columna] := Numero;
    clrscr;
    Writeln('Número ingresado con éxito.');
    Writeln('Sudoku actualizado:');
    ImprimirSudoku(Sudoku);
    end
    else
    begin
    Writeln('Número inválido. Intenta nuevamente.');
    end;

    WriteLn;
    Write('Presiona cualquier tecla para continuar...');
    ReadKey;
end;

procedure Rendirse(var Sudoku: TTableroSudoku);
begin
    Writeln('Te has rendido. Generando solución del Sudoku...');
    Writeln('Sudoku resuelto:');
    ResolverSudoku(Sudoku);
    ImprimirSudoku(Sudoku);

    WriteLn;
    Write('Presiona cualquier tecla para continuar...');
    ReadKey;
end;

{Los procedimientos rendirse o Ganaste, el primero es usado cuando el usuario no quiere continuar jugando, lo que hace es completar el sudoku e imprimirlo
mientras que el procedimiento ganast (que aun esta en desarrollo) contranda un dialogo de felicitaciones y la opcion de volver a jugar
Nota: se tiene visualizado que el procedimiento de rendirse tiene un pequeño bug que si llega a ingresar un dato que pueda influir en el algoritmo de backtracking
No se podra imprimir la solucion correcta, se tiene previsto como solucionarlo y en el proximo commit estara funcionando al 100%}
procedure Ganaste(var Sudoku: TTableroSudoku);
begin
    if ResolverSudoku(Sudoku) then
    begin
        clrscr;
        WriteLn('ganaste');
    end;
end;

{EL procedimiento de  borrar numero trabaja similar al del ingresarnumero, solicitando al usuario la fila y la columna de 
el numero que quiere eliminar, y procede a cambiarlo por un 0, luego se evalua que si ese elemento(fila, columna) es = 0, se dejara un espacio vacio}
procedure BorrarNumero(var Sudoku: TTableroSudoku);
var
    Fila, Columna, Numero: Integer;
begin
    ImprimirSudoku(Sudoku);
    Write('Ingresa la fila (1-9): ');
    ReadLn(Fila);
    Write('Ingresa la columna (1-9): ');
    ReadLn(Columna);

    Sudoku[Fila, Columna] := 0;
    if Sudoku[Fila, Columna] = 0 then
    begin
        writeln(' ');
    end;
    WriteLn;
    Write('Presiona cualquier tecla para continuar...');    
    ReadKey;
end;

{La funcion de SudokuCompleto, es la mas simple de toda, simplemente se recorre todos los elementos del array, si algunas de las celdas esta vacia
el sudoku no esta completo y devuelve el valor de false, y en caso contrario devolvera el valor de true.}
function SudokuCompleto(const Sudoku: TTableroSudoku): Boolean;
var
    Fila, Columna: Integer;
begin
    for Fila := 1 to 9 do
    begin
    for Columna := 1 to 9 do
    begin
      // Si alguna celda está vacía (con valor 0), el Sudoku no está completo
        if Sudoku[Fila, Columna] = 0 then
        Exit(False);
    end;
end;
  // Si todas las celdas tienen un valor distinto de 0, el Sudoku está completo
    SudokuCompleto := True;
end;

{El procedimiento mostarmenu, es utilizado mostrar el menu de opcion de juegos}
procedure MostrarMenu(const Sudoku: TTableroSudoku);
begin
    gotoxy(27, 1);
    Writeln('----- Sudoku -----');
    WriteLn('');
    gotoxy(1,1);
    ImprimirSudoku(Sudoku);
    gotoxy(29, 5);
    Writeln('----------------');
    gotoxy(29, 6);
    Writeln('1. Ingresar numero');
    gotoxy(29, 7);
    WriteLn('2. Borrar numero');
    gotoxy(29, 8);
    Writeln('3. Rendirse');
    gotoxy(29, 9);
    Writeln('0. Salir');
    gotoxy(27, 10);
    Writeln('----------------');
    gotoxy(27, 11);
    Writeln;
end;
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
		Writeln ('Por favor ingrese su nombre de usuario');
		Readln (username);
		Writeln ('Por favor ingrese su edad');
		Readln (userage);
		clrscr;
		writeln ('Los datos ingresados son:');
		Writeln ('Nombre: ', username);
		writeln ('Edad: ', userage);
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
			    Randomize;
                GenerarPistasSudoku(Sudoku, 17);

                repeat
                ClrScr;
                MostrarMenu(Sudoku);
                gotoxy(27, 10);
                Write('Selecciona una opcion: ');
                ReadLn(Opcion);
                ClrScr;

                case Opcion of
                1:begin
                    clrscr;
                    IngresarNumero(Sudoku);
                    if SudokuCompleto(Sudoku) then
                    begin
                        Ganaste(Sudoku);
                        Break; // Salir del bucle
                    end;
                    clrscr;
                end;
                2:begin
                    clrscr;
                    BorrarNumero(Sudoku);
                end;  
                3:begin
                    Rendirse(Sudoku);
                end;
    end;


            until Opcion = 0;
	end; 
			2: begin
			    instrucciones;
			end;
			3: begin
			end;
		end;
END.