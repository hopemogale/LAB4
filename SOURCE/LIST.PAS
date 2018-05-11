Unit Addr_List;

{ Unit to hide a linked list data structure from the main program. }

InterFace

Type
   Name_String = String[10];
   Addr = Record
      Last_Name,First_Name:Name_String;
      Street:String[40];
      City:String[10];
      State:String[2];
      Zip:String[10];
      Phone:String[15];
      Comment:String[40];
   End;

Procedure Load_File(FileName:String;Var Error:Boolean);


Implementation

Type
   Pntr = ^LL_Rec;
   LL_Rec = Record
      A:Addr;
      Next,Prev:Pntr;
   End;

Var
   First,Last,Curr:Pntr;
   F:File of Addr;
   Found:Boolean;

Procedure Init;
Begin
   First := Nil;
   Last  := Nil;
   Curr  := Nil;
   Found := False;

End;

Procedure Load_File(FileName:String;Var Error:Boolean);

Var
   Temp:Addr;P:Pntr;Err:Boolean;

Begin
   Init;
   Assign(F,Filename);
   {$I-} Reset(F);{$I+}
   If IOResult = 0 Then
   Begin
      While Not Eof(F) Do
      Begin
         Read(F,Temp);
         New(p);
         P^.A:=Temp;
         P^.Next:=Nil;
         P^.Prev:=Last;
         If (First=Nil) Then
            First := P
         Else
            Last^.Next:=P;
         Last:=P;
      End;
      Close(F);
   End
   Else
      Error:=True;
End;


Procedure Create_File(FileName:String);

Begin
   Assign(F,FileName);
   Init;
End;

Procedure Save_File;

Var P:Pntr;
Begin
   ReWrite(F);
   P:=First;
   While(P<>Nil) Do
   Begin
      Write(F,P^.A);
      First:=First^.Next;
      Dispose(P);
      P:=First;
   End;
   Init;
   Close(F);
End;

Procedure Find(Lname,Fname:Name_String;Var Rec:Addr;Var No_Match:Boolean);

Var Stop:Boolean;
Begin
   Stop:=False;
   No_Match:=True;
   While(Curr<>Nil) and No_Match and Not Stop Do
   Begin
      If(Lname>Curr^.a.Last_Name) Then
         Curr:=Curr^.Next
      Else If(Lname=Curr^.a.Last_Name) Then
      Begin
         If(Fname>Curr^.a.First_Name) Then
            Curr:=Curr^.Next
         Else If (Fname=Curr^.a.First_Name) Then
         Begin
            Rec:=Curr^.a;
            No_Match:=False;
         End
         Else
            Stop:=True;
      End
      Else
         Stop:=True;
   End;
End;


Procedure Find_First(Lname,Fname:Name_String;Var Rec:Addr;No_Match:Boolean);

Begin
   Curr:=First;
   Find(Lname,Fname,Rec,No_Match);
   Found:=Not No_Match;
End;

Procedure Find_Next(Lname,Fname:Name_String;Var Rec:Addr;No_Match:Boolean);

Begin
   Curr:=Curr^.Next;
   Find(Lname,Fname,Rec,No_Match);
End;

Procedure Add_Rec(Rec:Addr;Var Error:Boolean);

Var Temp:Addr;No_Match:Boolean;P:Pntr;
Begin
   If(MemAvail>SizeOf(Addr)) Then
   Begin
      Curr:=First;
      Find(Rec.Last_Name,Rec.First_Name,Temp,No_Match);
      New(P);
      P^.a:=Rec;
      P^.Next:=Curr;
      If Curr=Nil Then P^.Prev:=Last Else P^.Prev:=Curr^.Prev;
      If Curr=First Then First:=P
         Else If(Curr=Nil) Then Last^.Next:=P
            Else Curr^.Prev^.Next:=P;
      If Curr=Nil Then Last:=P Else Curr^.Prev:=P;
      Error:=False;
   End
   Else
      Error:=True;
End;

Procedure Delete_Rec;

Var P:Pntr;
Begin
   If Found And (Curr<>Nil) Then
   Begin
      With Curr^ Do
      Begin
         If Curr=First Then First:=Next Else Prev^.Next:=Next;
         If Curr= Last Then Last:=Prev Else Next^.Prev:=Prev;
         Dispose(Curr);
      End;
   End;
End;


Procedure Change_Rec(Rec:Addr);

Begin
   If Found And (Curr <> Nil) Then
      Curr^.A:=Rec;
End;

Function Size:Word;

Var Cnt:Word;P:Pntr;
Begin
   P:=First;
   Cnt:=0;
   While (P<>Nil) Do
   Begin
      P:=P^.Next;
      Cnt:=Cnt+1;
   End;
   Size:=Cnt;
End;

Function Full:Boolean;

Begin
   If MemAvail < SizeOf(Addr) Then Full:=True Else Full:=False;
End;

Begin
   Init;
End.