program EditorDemo;

uses Crt;

var
  OrigMode,LastCol,LastRow: Word;
  Ch: Char;
  Done: Boolean;

procedure Initialize;
{ Initialize the video mode, LastCol, LastRow, and the random number }
{ generator. Paint the help line. }
begin
  CheckBreak:=False;                   { turn off Contrl-C checking }
  OrigMode:=LastMode;                  { Remember original video mode }
  TextMode(Lo(LastMode)+Font8x8);      { use 43 or 50 lines on EGA/VGA }
  LastCol:=Lo(WindMax)+1;              { get last column, row }
  LastRow:=Hi(WindMax)+1;
  GoToXY(1,LastRow);                   { put message line on screen }
  TextBackground(Black);
  TextColor(White);
  Write(' Ins-InsLine  ',
        'Del-DelLine  ',
        #27#24#25#26'-Cursor  ',
        'Alt-W-Window  ',
        'Esc-Exit');
  Dec(LastRow,80 div LastCol);         { don't write on message line }
  Randomize;                           { init random number generator }
end; { Init }

procedure MakeWindow;
var
  X,Y,Width,Height: Word;
begin
  Width:=78;
  Height:=22;
  X:=1;
  Y:=1;
  Window(X,Y,X+Width,Y+Height);
  if OrigMode = Mono then
  begin
    TextBackground(White);
    TextColor(Black);
    ClrScr;
    Window(X+1,Y+1,X+Width-1,Y+Height-1);
    TextBackground(Black);
    TextColor(White);
    ClrScr;
  end
  else
  begin
    TextBackground(Random(8));
    TextColor(Random(7)+9);
  end;
  ClrScr;
end; { MakeWindow }


begin { program body }
  Initialize;
  MakeWindow;
  Done:=False;
  repeat
    Ch:=ReadKey;
    case Ch of
      #0:                               { Function keys }
      begin
        Ch:=ReadKey;
        case Ch of
          #17: MakeWindow;              { Alt-W }
          #45: Done:=True;              { Alt-X }
          #72: GotoXY(WhereX,WhereY-1); { Up }
          #75: GotoXY(WhereX-1,WhereY); { Left }
          #77: GotoXY(WhereX+1,WhereY); { Right }
          #80: GotoXY(WhereX,WhereY+1); { Down }
          #82: InsLine;                 { Ins }
          #83: DelLine;                 { Del }
        end;
      end;
      #3: Done:=True;                   { Ctrl-C }
      #13: WriteLn;                     { Enter }
      #27: Done:=True;                  { Esc }
    else
      Write(Ch);
    end;
  until Done;
  TextMode(OrigMode);
end.
