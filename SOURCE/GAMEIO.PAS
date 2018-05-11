Unit GameIO;

Interface

Uses Crt,TicTac;

Type                           { Define types for parameters  }
   CharSet           = Set of Char;
   MsgStr            = String[80];

Procedure DisplayGame(TheGame:Game);
Procedure DrawGrid;
Procedure ReadChar(VAr Ch : Char; Prompt : MsgStr; OKSet : CharSet);
Procedure ReadInt(Var Val : Integer;
                  Prompt  : MsgStr;
                  Low,High: Integer);

Implementation

Const
   BoardX                 = 10; {  Positioning the TicTacToe Grid }
   BoardY                 = 10;
   Bar                    = #186; { Special Characters used for Grid }
   Line                   = #205;
   Cross                  = #206;

Procedure DrawGrid;
{  Purpose          Draws full-sized tictactoe Grid,
                    with smaller numbered one beside it
   Pre              Screen has been cleared
   Post             Two grids drawn on screen          }

   Procedure DrawHorz(X,Y : Integer);
   { Purpose        Draws horizontal bar for tictactoe grid
     Pre            X <= 63, Y <= 23
     Post           Bar is written to screen            }

   Begin
      GoToXY(X,Y);
      Write(Line,Line,Line,Line,Line,Cross);
      Write(Line,Line,Line,Line,Line,Cross);
      Write(Line,Line,Line,Line,Line);
   End; { Procedure DrawHorz }

   Procedure DrawVert(X,Y:Integer);
   { Purpose       Draws vertical bars for tictactoe grid
     Pre           X <= 78, Y <= 16
     Post          Vertical Bar appears on screen(with gaps for crosses) }

   Var
      J,I:Integer;
   Begin
      For J := 1 to 3 Do Begin
         For I := 0 to 2 Do Begin
             GotoXY(X,Y+1);Write(Bar);
         End;
         Y := Y + 4;
      End;
   End;  { Procedure DrawVert }


   Procedure DrawMoves(X,Y: Integer);
   { Purpose        Draws 3 x 3 Grid with numbered positions
     Pre            x <= 77, Y <= 21
     Post           3 x 3 Grid Drawn on screen        }

   Begin
      GoToXY(X,Y);   Write('1',Bar,'2',Bar,'3');
      GoToXY(X,Y+1); Write(Line,Cross,Line,Cross,Line);
      GoToXY(X,Y+2); Write('4',Bar,'5',Bar,'6');
      GoToXY(X,Y+3); Write(Line,Cross,Line,Cross,Line);
      GoToXY(X,Y+4); Write('7',Bar,'8',Bar,'9');
   End;   { Procedure DrawMoves }

   Begin
      DrawHorz(BoardX,BoardY);
      DrawHorz(BoardX,BoardY+4);
      DrawVert(BoardX+5,BoardY-3);
      DrawVert(BoardX+11,BoardY-3);
      DrawMoves(BoardX+20,BoardY);
   End;   { Procedure DrawGrid }



   Procedure DisplayGame(TheGame:Game);
   { Purpose        Draws Status of TicTacToe Game on screen
     Pre            Grid has already been drawn on screen
     Post           Contents of each grid location are displayed }

   Var
      I,Col,Row : Integer;
      M         : Move;
   Begin
      For I := 1 to Glim Do Begin
         M := GetLoc(TheGame,I);
         Col := BoardX +2 +6 * ((I-1)mod 3);
         Row := BoardY -2 +4 * ((I-1)div 3);
         GoToXY(Col,Row);
         Case M Of
            Blank   : Write(' ');
            X       : Write('X');
            O       : Write('O');
         End;
      End;
   End; { Procedure DisplayGame }


   Procedure ReadChar(Var Ch : Char;Prompt:MsgStr;OKSet:CharSet);
   { Purpose         Prompt for and get one character of a given set
     Pre             OkSet is not-empty and contains valid uppercase
                     characters (including digits, punctuation, etc..)
     Post            ReadChar() returns some character contained in OkSet }

   Begin
      GoToXY(1,1); ClrEol;
      Write(Prompt);
      Repeat
         Ch := UpCase(ReadKey);
      Until Ch in OkSet;
      Write(Ch);
   End; { Procedure ReadChar }

   Procedure ReadInt(Var Val : Integer;
                     Prompt  : MsgStr;
                     Low,High: Integer);
   { Purpose         Prompt for and get an integer value in a given range
     Pre             Low <= High
     Post            ReadInt() Returns some value in the range Low..High }

   Begin
      {$I-}
      Repeat
         GoToXY(1,1); ClrEol;
         Write(Prompt,' (',Low,',',High,'): ');
         Readln(Val);
      Until (IOResult = 0) and (VAl >= Low) and (Val <= High);
      {$I+}
      End; { Procedure ReadInt }

End. { Unit GameIO }