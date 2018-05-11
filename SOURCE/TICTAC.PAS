Unit TicTac;

{ TicTac.pas  Unit for implement abstract data types
              Move,
              Location,
              Game
  Bye Bruce F. Webster, Last update 12 Dec 87          }

Interface

{ Definitions for abstract data Type Move }

Type
   Move   =   (Blank, X, O);

Function Opposite(M : Move) : Move;

Const
   GLim   =   9;

Type
   Location   =   1..GLim;

{ Definitions for abstract data type Game }

Type
   Board          =  Array[Location] of Move;
   Game           =  Record
      Grid        :  Board;
      Next,Win    :  Move;
      Moves       :  Integer;
   End;

Function GetLoc(Var G : Game; L : Location) : Move;
Function NextMove(G:Game) : Move;
Function MovesMade(G:Game) : Integer;
Function GameOver(Var G : Game) : Boolean;
Function Winner(G:Game) : Move;
Procedure DoMove(Var G : Game; L : Location);
Procedure NewGame(Var G : Game;First : Move);

Implementation

Function Opposite(M:Move):Move;
{ Purpose      Return opposite of value passed.
  Pre          m has a value of X, O, or Blank.
  Post         If M = X, Then returns O
               If M = O, Then returns X
               Else returns Blank                }

Begin
   Case M of
      Blank   : Opposite := Blank;
      X       : Opposite := O;
      O       : Opposite := X;
   End ;
End;  { Procedure Opposite }

Procedure SetLoc(Var G: Game; L : Location; M : Move );
{  Purpose       Sets a location in the game to a given value
   Pre           L is in the range 1..9
                 M has a value of X, O, or Blank
   Post          Location L in the game has the value M.      }

Begin
   G.Grid[L] := M;
End;  { Procedure SetLoc }

Function GetLoc(Var G : Game; L : Location) : Move;
{ Purpose        Returns the value of a given location in the game.
  Pre            G has been initialized, L is in the range of 1..9
  Post           Returns the value of G, at a location.            }

Begin
   GetLoc := G.Grid[L];
End;  { Function GetLoc }


Function NextMove(G:Game):Move;
{ Purpose        Returns the next move
  Pre            G has been initialized
  Post           If the game is not over then it returns X
                 or O or Blank.                            }

Begin
   NextMove := G.Next;
End;   { Function NextMove }



Function MovesMade(G:Game):Integer;
{ Purpose        Returns number of moves made in the game so far
  Pre            G has been initialized
  Post           Returns a value in the range of 0..9           }

Begin
   MovesMade := G.Moves;
End;   { Function MovesMade }

Procedure InARow(Var G : Game; I,J,K : Location);
{ Purpose         Checks for three X's or O's in a row
  Pre             G has been initialized, O or More moves made
  Post            If Locations I, J, K all have the same value
                  and that value is not Blank, then the winner
                  is set to that value                        }

Begin
   With G Do Begin
      If Win = Blank Then Begin
         If (Grid[I] = Grid[J]) and (Grid[J] = Grid[K])
            And (Grid[I] <> Blank) Then Win := Grid[I];
      End;
   End;
End; { Procedure InARow }

Procedure CheckForWin(Var G : Game; L : Location);
{  Purpose        See if last move won the game
   Pre            G has been initialized, 1 or more moves made,
                  L is in the range 1..9, Location L has X or O,
                  Last move was made at location L.
   Post           If L forms 3 X's or O's in a row, Then
                  the winner is set to that value.               }

Begin
   Case L of
      1  :  Begin
               InARow(G,1,2,3);
               InARow(G,1,5,9);
               InARow(G,1,4,7);
            End;
      2  :  Begin
               InARow(G,1,2,3);
               InARow(G,2,5,8);
            End;
      3  :  Begin
               InARow(G,1,2,3);
               InARow(G,3,5,7);
               InARow(G,3,6,9);
            End;
      4  :  Begin
               InARow(G,1,4,7);
               InARow(G,4,5,6);
            End;
      5  :  Begin
               InARow(G,1,5,9);
               InARow(G,2,5,8);
               InARow(G,3,5,7);
               InARow(G,4,5,6);
            End;
      6  :  Begin
               InARow(G,3,6,9);
               InARow(G,4,5,6);
            End;
      7  :  Begin
               InARow(G,1,4,7);
               InARow(G,3,5,7);
               InARow(G,7,8,9);
            End;
      8  :  Begin
               InARow(G,2,5,8);
               InARow(G,7,8,9);
            End;
      9  :  Begin
               InARow(G,1,5,9);
               InARow(G,3,6,9);
               InARow(G,7,8,9);
            End;
   End;
End;  { Procedure CheckForWin }


Function GameOver(Var G: Game) : Boolean;
{ Purpose           Returns the status of the Game (Over or Not)
  Pre               G has  been initialized, O or more moves have
                    been made.
  Post              If Game is over,
                       Then Returns True
                       Else returns False.                      }

Begin
   GameOver := (G.Win <> Blank) Or (G.Moves = Glim)
End;   { Function GameOver }



Function Winner(G:Game):Move;
{  Purpose          Returns Winner of Game
   Pre              G has been initialized, The game is over
   Post             If there are 3 X's in a row, Returns X
                    If there are 3 O's in a row, Returns O
                    Else returns Blank (Draw)               }

Begin
   Winner := G.Win;
End; { Function Winner }


Procedure DoMove(Var G:Game;L:Location);
{  Purpose           Make next move in game
   Pre               G has been initialized, O or more moves made,
                     the game is not over, L is in the range 1..9,
                     Getloc(G,L) is Blank
   Post              The next move is made at location L
                     a possible win is checked
                     If game is not over,
                        Then move is toggled
                        Else the next move is set to Blank     }

Begin
   With G Do Begin
      SetLoc(G,L,G.Next);
      Moves := Moves + 1;
      CheckForWin(G,L);
      If not GameOver(G)
         Then Next := Opposite(Next)
      Else Next := Blank
   End;
End;  { Procedure DoMove }



Procedure NewGame(Var G: Game; First : Move);
{  Purpose          Initialize a new game
   Pre              First has a value of X or O
   Post             G has been initialized:
                      Locations 1..9 are setBto Blank
                      the next move is set to first
                      the winner is set to Blank
                      the number of moves is set to 0 }

Var
   I           : Integer ;
Begin
   With G Do Begin
      For I := 1 to Glim Do
         SetLoc(G,I,Blank);
      Next  := First;
      Win   := Blank;
      Moves := 0;
   End;
End;  { Procedure NewGame  }


End.   { Unit TicTac }
