Unit Xception;  { Exception handling via Catch and Throw }

{$D+}

Interface

Type
   Target = Record
            Private: Array[1..10] of Byte; { Abstract Data Type }
            Point: Pointer;
            End;
   ExceptionMode =
        (ExceptionSet, ExceptionUsed);

Function Catch(Var Exception: Target): ExceptionMode;

Procedure Throw(Var Exception: Target);

Function CanonicThrowingPoint(Var Exception: Target): Pointer;

Implementation

{$L Xception.Obj }

Function Catch(Var Exception: Target): ExceptionMode; External;

Procedure Throw(Var Exception: Target); External;

Function CanonicThrowingPoint(Var Exception: Target): Pointer;

Type
   DWord = Record
            Lo, Hi: Word;
            End;

Begin
   Dec(DWord(Exception.Point).Hi,PrefixSeg + $10);
   CanonicThrowingPoint := Exception.Point;
End;

End.