{$R-}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}

Program WS2ASCII ;

Uses Crt;

{ To convert Wordstar Files to ASCII Text Files }



CONST
     TempName = 'Temp.@@@' ;

VAR
   FileName : String[64] ;

Procedure ProcessFile ;

Var
   i : Integer ;
   InFile, OutFile : Text ;
   Ch : Char ;

Begin
     Assign(InFile, FileName) ;
     Reset(InFile) ;
     Assign(OutFile, TempName) ;
     Rewrite(OutFile) ;
     While NOT Eof(InFile) DO
     Begin
          Read(InFile, Ch) ;
          Ch := Chr(Ord(Ch)Mod 128) ;
          If Ch = Chr(13)
             Then Writeln(OutFile) Else
          If Ch >= ' '
             Then Write(OutFile,Ch) ;
     End ;  { While }
     Close(InFile) ;
     Close(OutFile) ;
     Erase(InFile) ;
     Rename(OutFile,FileName) ;
End ;   { ProcessFile }

Begin
     ClrScr;
     WriteLn('           WordStar To ASCII File ConVerter ') ;
     WriteLn ;
     Write('            Convert What File ? ') ;
     Readln(FileName) ;
     If Length(FileName) > 0
        Then ProcessFile
End .
