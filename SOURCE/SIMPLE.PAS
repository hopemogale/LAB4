{$I-}
{$S-}
{$R-}
Program Simple;

Uses Crt;

{ Unit BinEd ; }
     { The Borland binary editor interface for Turbo Pascal }

{ Interface }

Const
     MaxFileSize = $FFE0 ;      { Maximum editable file size }
     EdOptInsert = $1 ;         { Insert on flag }
     EdOptIndent  = $2 ;        { Autoindent on flag }
     EdOptTAB = $8 ;            { Tab on flag }
     EdOptBlock = $10 ;         { Show Marked Block }
     EdOptNoUpdate = $20 ;      { Don't update screen when entering editor }
     EventKBflag = 1 ;          { Scroll, num or caps locks modified mask }
     CAnorm = #255#1 ;          { Activates CRT "normal" attribute }
     CAlow = #255#2 ;           { Activates CRT "low" attributes }
     CAblk = #255#3 ;           { Activates CRT "block"  attributes }
     CAerr = #255#4 ;           { Activates CRT "error" attributes }
     EdStatTExtMod = 1;         { Text buffer modified mask }
     EXitCommandArray : Array[0..6] of Char = (#2,^K,^X,#2,^K,^Q,#0);

Type
    AttrArray = Array[0..3] of Byte ;
    ASCIIZ = Array[0..255] of Char ;
    ASCIIZptr = ^ASCIIZ ;
    TextBuffer = Array[0..$FFF0] of Char ;
    CRTinsStruct =              { CRT installation structure }
      Record
            CRTtype : Byte ;    { 1=IBM, 0=Non }
            CRTx1,CRTy1,
            CRTx2,CRTy2 : Byte ;{ Initial Window Size }
            CRTmode : Byte ;    { Initial mode 0-3, 7 or FF(default)}
            CRTsnow : Byte ;    { 0 if no snow, don't care for mono }
            AttrMono : AttrArray ; { CRT attributes for mono mode }
            AttrBW : AttrArray ;   { CRT attributes for B/W mode }
            AttrColor : AttrArray ;{ CRT attributes for Color Modes }
      end ;
    CIptr = ^CRTinsStruct ;
    EdInsStruct =             { Command table installation structure }
      Record
            ComTablen : Word ; { Maximum length of command table }
            ComTab : TextBuffer ; { Command Table }
      end ;
    EIptr = ^EdInsStruct ;
    MIinsStruct =                 { Main installation structure }
      Record
            Ver : Byte ;          { Main version }
            VerSub : Byte ;       { Sub version }
            VerPatch : Char ;     { Patch level }
            CPUmhz : Byte ;       { CPU speed for delays }
            CIstruct : CIptr;     { Points to CRT installation record }
            EIstruct : EIptr ;    { Points to Editor installation area }
            DefExt : ASCIIZptr ;  { Points to ASCIIZ default extension }
      end ;
    MIptr = ^MIinsStruct ;
    EdCB =                        { Editor control block in detail }
      Record
            x1, y1, x2, y2 : Byte;{ UL & LR corners of editor window}
            DataSeg : Word ;      { Segment address of editor data area }
            DataSegLen : Word ;   { Requested data area length (bytes) }
            Options : Word ;      { Bit flags for editor options }
            FileStr : ASCIIZptr ; { Points to ASCIIZ filename }
            Commands : ASCIIZptr ;{ Points to string of editor commands }
            Place1 : ASCIIZptr ;  { Not used here }
            Place2 : ASCIIZptr ;  { Not used here }
            Event : Pointer ;     { Points to event handling procedure }
            Buffer : ^TextBuffer ;{ Points to text area }
            BufSize : Word ;      { Available size for text }
            MIStruct : MIptr ;    { Points to main installation record }
            ComTab : ASCIIZptr ;  { Points to terminate command table }
            EOText : Word ;       { Current number of chars in text buffer }
            CursorPos : Word ;    { Current cursor position in buffer }
            BlockStart : Word ;   { Start of marked block in buffer }
            BlockEnd : Word ;     { End of marked block in buffer }
            Status : Word ;       { Editor  status }
            DataPtr : ^TextBuffer ;{ Points to Turbo heap block }
      end ;                       { Allocated for text buffer }

Const
   { CRT attributes for normal low blk error }
   MonoArray : AttrArray = ($F, $7, $7, $70);
   BwArray : AttrArray = ($F, $7, $7, $70);
   ColorArray : AttrArray = ($E, $7, $3, $1E);

{ -------------------------------------------------------------- }



Procedure CRTputFast(x, y : Word; s : string);
   { -Use binary editor services to write a string to the screen }
   { x in 1..25, y in 1..80}



Function ExpandPath(fname : string) : string ;
   { -Return a complete path using the binary editor services }



Function InitBinaryEditor(
   Var EdData : EdCb;              { Editor control block }
   DataLen : Word ;                { Size of binary editor workspace }
   Cx1 : Byte ;                    { Editor window, upper left x 1..80 }
   Cy1 : Byte ;                    { Editor window, upper left y 1..25 }
   Cx2 : Byte ;                    { Editor window, lower right x 1..80 }
   Cy2 : Byte ;                    { Editor window, Lower right y 1..25 }
   WaitForRetrace : Boolean ;      { True for snowy color cards }
   Coptions : Word ;               { Initial Editor options }
   DefExtension : String ;         { Default file extension }
                                   { (must start with a period ) ! }
   Var ExitCommands ;              { Commands to exit editor }
   UserEventProcPtr : Pointer      { Pointer to user event handler }
   ) : Word ;

{ -Initialize the binary editor, returning a status code }
{ Status Codes -
  0 = Successful initialization
  1 = Insufficient memory space for text buffer
  }

Function ReadFileBinaryEditor(Var EdData : EdCb ;
                                  Fname : String ) : Word ;
  { -Read a file into the binary editor buffer space. }
  { Returning a status code }
  { Status Codes -
      0 = Successful read
      1 = File not found, new file assumed
      2 = File too large to edit
      }

Procedure ResetBinaryEditor(var EdData : EdCb);
   { -Call the editor reset procedure }

Function UseBinaryEditor(Var EdData           : EdCb;
                                StartCommands : String) : Integer;
   { -Edit File, using startcommands, and returning an exitcode }
   { Exit Codes -
      -1 = Editing terminated with ^KD
       0 = Editing terminated with first user-specified exit command
       1 ...
       }

Function ModifiedFileBinaryEditor(Var EdData : EdCb) : Boolean ;
   { -Return true if text buffer was modified during edit }

Function FileNameBinaryEditor(Var EdData : EdCb) : String;
   { -Return the current file pathname of the specified control block }

Function SaveFileBinaryEditor(Var EdData     : EdCb;
                                  MakeBackup : Boolean ) : Word ;
   { -Save the current file in the editor text buffer, }
   { Returning a status Code }
   { Status Codes -
      0 = Successful save
      1 = File creation error
      2 = Disk Write error
      3 = Error closing file
      }

Procedure ReleaseBinaryEditorHeap(Var EdData : EdCb);
   { -Release heap space used by a binary editor control block }
{
Implementation


end.}

Const ExitCommands : Char = #0;
{ Var EdData : EdCb; }


Procedure Abort(Msg:String);

Begin  { Abort }
   GoToXY(1,25);Write(Msg);Halt(1);
End;  { Abort }


Begin  { Main }
   If (ParamCount = 0) Then
      Abort('Usage: Simple Filename.Ext ');
   If (InitBinaryEditor(EdData,MaxFileSize,1,1,80,25,
      True, EdOptInsert,'',ExitCommands,nil) <> 0) Then
         Abort('Unable to Load Binary Editor.');
   If (ReadFileBinaryEditor(EdData,ParamStr(1)) > 1) Then
      Abort('Unable to Read ' + ParamStr(1));
   ResetBinaryEditor(EdData);
   If (UseBinaryEditor(EdData,'')= -1)  Then
      If ModifiedFileBinaryEditor(EdData) Then
         If (SaveFileBinaryEditor(EdData,True)<>0) Then
            Abort('Error Saving File. ');
   GoToXY(1,25);
End. { Main }
