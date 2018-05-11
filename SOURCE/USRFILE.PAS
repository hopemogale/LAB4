{$R-,I+,N-}
Program UsrFile;

Uses Crt,Dos;

Const
   UsrSiz          = 255;
   IO_NotOutput    = 105;
   IO_FileFull     = 101;
   IO_Invalid      = 6;

Type
   String255    = String[255];
   CharBuf = Array[0..127] of Char;
   FakeFile = Array[0..UsrSiz] Of Char;
   TextRec = Record
      Handle       : Word;
      Mode         : Word;
      BufSize      : Word;
      Private      : Word;
      BufPos       : Word;
      BufEnd       : Word;
      BufPtr       : ^CharBuf;
      OpenFunc     : Pointer;
      InOutFunc    : Pointer;
      FlushFunc    : Pointer;
      CloseFunc    : Pointer;
      UFilePos     : Word;
      UFileSiz     : Word;
      Data         : ^FakeFile;
      UserData     : Array[1..16] of Byte;
      Name         : Array[0..79] Of Char;
      Buffer       : CharBuf;
   End;

Var
   UFile : Text;
   Ch    : Char;
   N,D   : Integer;

{$F+} { Start Making all Routines Far }
Function UsrOpen(Var F: TextRec): Integer;

Begin
   UsrOpen := 0;
   With F Do
      If Mode = FmOutput Then
         Begin
            UFileSiz := 0;
            UFilePos := 0;
         End
      Else UsrOpen := IO_Invalid;
End;