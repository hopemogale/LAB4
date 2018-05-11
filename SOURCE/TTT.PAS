Program PlayGame;
{ Purpose            Implement Tic-Tac-Toe on the Computer
  Author             Bruce F. Webster
  Last UpDate        12 Dec 1987 -- 100 mst              }

Uses
   Crt,
   TicTac,
   Moves,
   GameIO;

Procedure StartGame(Var TheGame:Game);
{ Purpose            Set up a new Game
  Pre                None
  Post               G,Cflag,Cmove have been initialized
                     no moves have been made
                     The TicTacToe Grid has been drawn on the screen }

Var
  Ans       : Char;

Begin
   ClrScr;
   ReadChar(Ans,'Who Moves First:  H)uman or C)omputer? ',['H','C']);
   If Ans = 'C'
      Then CFlag := 0
      Else CFlag := 1;
   ReadChar(Ans,'Do You Wish to be X or O? ',['X','O']);
   If Ans = 'X'
      Then CMove := O
      Else CMove := X;
   If CFlag <> 0
   Then NewGame(TheGame,Opposite(CMove))
   Else NewGame(TheGame,CMove);
   DrawGrid;
   DisplayGame(TheGame);
End;  { Procedure Initialize }


Procedure GetMove(TheGame:Game;Var L:Location);
{  Purpose        Select the next move for the game
   Pre            G has been Initialized
                  0 or more moves have been made,
                  The Game is not yet over
   Post           L contains a value from 1..9
                  GetLoc(G,L) is Blank        }

Var
   I        : Integer;

Begin
   If (MovesMade(TheGame) mod 2) = CFlag
   Then GenerateMove(TheGame,L)
 Else Begin
   Repeat
      ReadInt(I,'Enter Move ',1,9);
      If GetLoc(TheGAme,I) <> Blank
      Then Write(^G)
   Until GetLoc(TheGame,I) = Blank;
   L := I;
   End;
End; { Procedure GetMove }


Procedure ShowResults(Var TheGame : Game);
{  Purpose            Show Results of TicTacToe Game
   Pre                G Has been initialized, 5 or more moves have been made,
                      The game is not yet over.
   Post               The results of the game are displayed on the screen  }

Var
   M      : Move;

Begin
   M := Winner(TheGame);
   GoToXY(1,1); ClrEol;
   Case M of
      Blank     : Write('The Game was a Draw! ');
      X         : Write('X is the Winner! ');
      O         : Write('O is the Winner! ');
   End;
   Write(' -- Press Any Key to Continue ( Q to Quit )  ');
End;  {  Procedure ShowResults }

{ Procedure CleanUp ? }

Var
   TheGame           : Game;
   Next              : Location;
   Ch                : Char;

Begin      { Main body of Program }
   Repeat
      StartGame(TheGame);
      Repeat
         GetMove(TheGame,Next);
         DoMove(TheGame,Next);
         DisplayGame(TheGame);
      Until GameOver(TheGame);
      ShowResults(TheGame);
      Ch := ReadKey;
   Until (Ch in ['Q','q']);
      ClrScr;
End.  {  Program TicTacToe }
