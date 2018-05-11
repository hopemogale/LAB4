Unit Crt;

Interface

Const
{ CRT Modes }
   BW40  = 0;      { 40 x 25 B/W on a Color Adapter }
   C40   = 1;      { 40 x 25 on Color Adapter }
   BW80  = 2;      { 80 x 25 B/W on a Color Adapter }
   C80   = 3;      { 80 x 25 on Color Adapter }
   Mono  = 7;      { 80 x 25 on a Monochrome Adapter }
   Last  = -1;     { Last Active Text Mode }

{ ForeGround and BackGround Color Constants }

   Black     = 0;
   Blue      = 1;
   Green     = 2;
   Cyan      = 3;
   Red       = 4;
   Magenta   = 5;
   Brown     = 6;
   LightGray = 7;

{ Foreground color constants }

   DarkGray    = 8;
   LightBlue   = 9;
   LightGreen  = 10;
   LightCyan   = 11;
   LightRed    = 12;
   LightMagenta = 13;
   Yellow       = 14;
   White        = 15;

{ Add-in For Blinking }
   Blink        = 128;

Var

{ Interface Variables }

   CheckBreak:Boolean;       { Enable Ctrl-Break }
   CheckEOF:Boolean;         { Enable Ctrl-Z     }
   DirectVideo:Boolean;      { Enable direct Video addressing }
   CheckSnow:Boolean;        { Enable Snow Filtering }
   TextAttr:Byte;            { Current Text attribute }
   WindMin:Word;             { Window Upper Left Cordinates }
   WindMax:Word;             { Window Lower Right Coordinates }

{ Interface Procedures }

Procedure AssignCrt(Var F:Text};
Function KeyPressed:Boolean;
Function ReadKey:Char;
Procedure TextMode(Mode:Integer);
Procedure Window(X1,Y1,X2,Y2:Integer);
Procedure GotoXY(X,Y:Integer);
Function WhereX:Integer;
Function WhereY:Integer;
Procedure ClrScr;
Procedure ClrEol;
Procedure InsLine;
Procedure DelLine;
Procedure TextColor(Color:Integer);
Procedure TextBackGround(Color:Integer);
Procedure LowVideo;
Procedure HighVideo;
Procedure NormVideo;
Procedure Delay(MS:Integer);
Procedure Sound(Hz:Integer);
Procedure NoSound;