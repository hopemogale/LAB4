Program BinarySearchLogic;
        { Change Maximum from 10 to 100, 200, 500, 1000, 5000, 10000
        and 15000 and see how many additional passes it takes as the
        Data Base gets larger. }

{ Suggestion: Add the timer program to this one and let it run
  automatically to see just how fast it is on an ORDERED Grouping. }

{$I Routine.Inc}
Var
   Minimum, Maximum, UnknownNumber, Turns, Guess, Range: Integer;
   Found:Boolean;

Procedure Initialize;

Begin
   ClrScr;
   Found := False;
   Turns := 1;
   Guess := 0;
   Minimum := 0;
   Maximum := 16000; { Why should you avoid integers larger than 163837}
   UnknownNumber := Random(Maximum);
   Writeln('I am thinking of a number between 1 and ',Maximum,
           'Can you guess it?') ;
End;

Procedure PrintStatus;
Begin
   Range := (Maximum - Minimum);
   Writeln('You now know that the target must be between ',
            Minimum:5,' and',Maximum:5,'.');
   Writeln('Your next guess will be the midpoint of thie ',Range:5,
            ' Character Range.')
End;

Procedure GetGuess;
Begin
{ Comment out the next line for automatic demonstration.}
   WaitForAnyKey;
   Guess := (Minimum + Maximum) DIV 2;
        { Determine the Midpoint range. }
   Writeln('Your Guess is ',Guess);
End;

Procedure GetAndEvaluateGuess;

Begin
   GetGuess;
   While Not Found Do
      Begin
         If Guess = UnknownNumber Then
            Begin
               Writeln('The Unknown Number Was ',UnknownNumber);
               Found := True;
            End;
         If Guess < UnknownNumber Then { Unknown Number is in
                                         upper half of range. }
            Begin
               Writeln('Too Low. ');
               Turns := Turns + 1;
               Minimum := Guess ;  { New Range becomes top half of old range.}
               PrintStatus;
               GetGuess;
            End;
      End; { While }
End ; { GetAndEvaluateGuess }

Begin
   Initialize;
   GetAndEvaluateGuess;
   Writeln('It took',Turns:3,' Tries to find the number. ');
   Writeln ;
End.