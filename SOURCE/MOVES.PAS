Unit Moves;

{ Moves.Pas Unit for making computer's moves for the TicTacToe
  game. Author Bruce F. Webster.  Last Update 12 Dec. 1987    }

Interface

Uses TicTac;

Var
   CFlag            : Integer; { O if computer moves first, 1 otherwise }
   CMove            : Move;    { Contains computer's market (x,o)       }

Procedure GenerateMove(G:Game;Var L:Location);

Implementation


Function WinFound(G:Game;Var L:Location):Boolean;
{ Purpose         Checks for winning move in Game
  Pre             G Has been initialized, O or more moves have been made,
                  the game is not yet over
  Post            If the next move can win the game
                  Then L is set to that move and WinFound() returns True
                  Else L is unchanged and WinFound()  returns False    }

Var
   Temp        : Game;
   I           : Integer;

Begin
   I := 1;
   WinFound := False;
   Repeat
      If GetLoc(G,I) = Blank Then Begin
         Temp := G;
         DoMove(Temp,I);
         If GameOver(Temp) and (Winner(Temp) <> Blank) Then Begin
            L := I;
            WinFound := True;
            Exit;
         End;
      End;
      I := I + 1;
   Until I > Glim;
End; { Function WinFound }

Function BlockFound(G:Game;Var L :Location):Boolean;
{  Purpose         Checks for Blocking move in game
   Pre             G Has been initialized, O or more moves have been made,
                   The game is not over yet.
   Post            If the next move can prevent the following move from
                   winning the game
                   Then L is set to that move and BlockFound() returns True
                   Else L is unchanged and BlockFound() returns False  }

Var
   Temp          : Game;
   I             : Integer;
   J             : Location;
Begin
   I := 1;
   BlockFound := False;
   Repeat
      If GetLoc(G,I) = Blank Then Begin
         Temp := G;
         DoMove(Temp,I);
         If Not WinFound(Temp,J) Then Begin
            L := I;
            BlockFound := True;
            Exit;
         End;
      End;
      I := I + 1;
   Until I > Glim;
End; { Function BlockFound }

Procedure GenerateMove(G:Game;Var L : Location );
{ Purpose      Generates Next move for computer
  Pre          G has been initialized, O or more moves have been made,
               the game is not yet over.
  Post         *L contains a value in the range 1..9,
               GetLoc(G,*L) returns blank
  Strategy     Goes First for move to the Center (*L == 5)
               Then focuses on corners, then moves randomly
               always looks for a winning move
               After 3 or more moves, also looks for blocking moves
  Analysis     Not perfect, but simple and effective; won't always win
               when it could, but always plays to at least a draw.  }

Var
   NMoves      : Integer;
Begin
   L := 5;
   NMoves := MovesMade(G);
   If NMoves <= 2 Then Begin
     If GetLoc(G,L) = Blank
        Then Exit;
   End;
   If WinFound(G,L) Then Exit;
   If (NMoves > 2) and BlockFound(G,L) Then Exit;
   Repeat
      If NMoves <= 4
         Then L := 1 + 2 * Random(5)
         Else L := 1 + Random(Glim);
   Until GetLoc(G,L) = Blank;
End; { Procedure GenerateMoves }


End. { Unit Moves }
