Program TestBox;

Uses Crt,Box;

Begin
   ClrScr;
   DrawBox(5,8,15,64);
   BottomLeftCorner := #212;
   BottomRightCorner := #190;
   BottomLine := #205;
   DrawBox(3,30,20,58);
   GoToXY(1,24);
End.
