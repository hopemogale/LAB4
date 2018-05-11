Unit Box;

Interface

{ Nov-Dec 1987 Turbo Technix }

Uses Crt;

Var     TopLine            : Char;
        LeftLine           : Char;
        BottomLine         : Char;
        RightLine          : Char;
        TopLeftCorner      : Char;
        TopRightCorner     : Char;
        BottomLeftCorner   : Char;
        BottomRightCorner  : Char;

Procedure DrawBox(Top,Left,Bottom,Right:Integer);

Implementation

Const
        DefTop             = #205;
        DefLeft            = #179;
        DefBottom          = #196;
        DefRight           = #179;
        DefTopLeft         = #213;
        DefTopRight        = #184;
        DefBottomLeft      = #192;
        DefBottomRight     = #217;

Procedure DrawBox(* (Top,Left,Bottom,Right:Integer)*);

Var
     X,Y : Integer;

Begin
   GotoXY(Left,Top);
   Write(TopLeftCorner);
   GotoXY(Right,Top);
   Write(TopRightCorner);
   GotoXY(Left,Bottom);
   Write(BottomLeftCorner);
   GotoXY(Right,Bottom);
   Write(BottomRightCorner);
   GotoXY(Left+1,Top);
   For X:=(Left+1) to (Right-1) DO
      Write(TopLine);
   GotoXY(Left+1,Bottom);
   For X:=(Left+1) To (Right-1) DO
      Write(BottomLine);
   For Y:=(Top+1) To (Bottom-1) DO Begin
      GotoXY(Left,Y);
      Write(LeftLine);
      GotoXY(Right,Y);
      Write(RightLine);
   End; {For}
End; {DrawBox}

Begin { Unit Initialization }
   TopLine := DefTop;
   LeftLine := DefLeft;
   BottomLine := DefBottom;
   RightLine := DefRight;
   TopLeftCorner := DefTopLeft;
   TopRightCorner := DefTopRight;
   BottomLeftCorner := DefBottomLeft;
   BottomRightCorner := DefBottomRight;
End.