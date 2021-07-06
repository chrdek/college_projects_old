program Bankers;
USES CRT;

CONST
 Max_N = 50;
 Max_M = 20;

TYPE
 Vector = ARRAY [1..Max_M] OF Integer;
 Matrix = ARRAY [1..Max_N,1..Max_M] OF Integer;

VAR
 Infile1,Infile2,Outfile,HelpFile:Text;
 Work,Available,Request:Vector;
 Max,Allocation,Need:Matrix;
 N,M,I,J,K,PN:Integer;
 Selection:Char;
 SAFE:Boolean;
(*******************************************************************************
			Bankers Algorithm Simulator
                           Date: 01/01/2004

(******************************************************************************)
PROCEDURE ScreenOut;
Begin

Readln(Infile1,N,M);
FOR I:=1 TO M DO
 Read(Infile1,Available[I]);

Writeln('AVAILABLE');
Writeln('---------');
FOR I:=1 TO M DO
 Write(Available[I]:3);

Readln;

FOR I:=1 TO N DO
  FOR J:=1 TO M DO
 Read(Infile1,Max[I,J]);

Writeln;
Writeln('MAX MATRIX');
Writeln('----------');
FOR I:=1 TO N DO
Begin
Writeln;
  FOR J:=1 TO M DO
 Write(Max[I,J]:3);
end;
Readln;


FOR I:=1 TO N DO
  FOR J:=1 TO M DO
 Read(Infile1,Allocation[I,J]);

Writeln;
Writeln('ALLOC MATRIX');
Writeln('------------');
FOR I:=1 TO N DO
Begin
Writeln;
  FOR J:=1 TO M DO
 Write(Allocation[I,J]:3);
end;
 Readln;


Read(Infile2,PN);
FOR I:=1 TO M DO
 Read(Infile2,Request[I]);

Writeln;
Writeln('REQUESTS');
Writeln('--------');
FOR I:=1 TO M DO
 Write(Request[I]:3);

Readln;


FOR I:=1 TO N DO
  FOR J:=1 TO M DO
 Need[I,J]:=Max[I,J]-Allocation[I,J];

Writeln;
Writeln('NEED');
Writeln('----');
FOR I:=1 TO N DO
Begin
Writeln;
  FOR J:=1 TO M DO
 Write(Need[I,J]:3);
end;

Readln;
end;
(******************************************************************************)
PROCEDURE SafetyAlg(VAR SAFE:Boolean);

TYPE
 Safetyarray = ARRAY [1..Max_N] OF Boolean;

VAR
 Finish:Safetyarray;
 Counter:Integer;


Begin

FOR I:=1 TO M DO
 IF (Request[I] <= Need[PN,I]) AND (Request[I] > Work[I]) THEN
  Begin
   clrscr;
   Writeln('REQUEST CANNOT BE GRANTED');
   Writeln;
   Writeln('PROCESS HAS TO WAIT UNTIL THERE ARE ENOUGH RESOURCES AVAILABLE');
  end
   ELSE
Begin  {BEGIN ELSE}
     FOR I:=1 TO M DO
  Begin
   Work[I]:=Work[I]+Available[I];                     {Initialize Work Variable}
                                                         {add Avail to Work}
                                                      {safety algorithm starts}


   Available[I]:=Available[I] - Request[I];           {Here, We Pretend to have}
   Allocation[PN,I]:=Allocation[PN,I] + Request[I];   {allocated the requested}
   Need[PN,I]:=Need[PN,I] - Request[I];               {resources to process PN}

  end;

 FOR I:=1 TO N DO
  Begin
   Finish[I]:=False;
   Counter:=0;
    IF Finish[I]=False THEN                           {The Safety Algorithm}
     For J:=1 to M do                                   {Takes Place Here}
       IF Need[I,J] <= Work[J] Then                   
          Begin {BEGIN IF-1}
           Counter:=Counter+1;
            If Counter=M then
            Begin {BEGIN IF-2}
             For K:=1 to M do
               Work[K]:=Work[K]+Allocation[I,K];
               Finish[I]:=True;
               SafetyAlg(SAFE);                        {Go Back to Step 2}
            end; {END IF-2}
          end; {END IF-1}
  end;
end;  {END ELSE}

FOR I:=1 TO N DO
 IF Finish[I]=True THEN
  SAFE:=True                             {The Safety Algorithm Ends Here}
   ELSE                                  {Step 4 of Bankers:State whether}
  SAFE:=False;                           {We Have a safe or Un-safe state}

end;
(******************************************************************************)
PROCEDURE BankersAlg1(Request:Vector;
                      Need:Matrix;
                      VAR PN:Integer);


Begin

FOR I:=1 TO M DO
    IF Request[I] > Need[PN,I] THEN
     Begin
       clrscr;
       Writeln('REQUEST NOT GRANTED (REQUEST > NEED)');
       Writeln;
       Writeln('TERMINATING PROCESS...');
      end
        ELSE
        Begin
          clrscr;
          Writeln('REQUEST GRANTED!');
          Writeln;
          Writeln('PROCEED TO STEP 2 + SAFETY...');
          Readln;
          SafetyAlg(SAFE);
        end;

CASE SAFE OF False:   {BEGIN OF CASE}
Write('REQUEST CANNOT BE GRANTED - SYSTEM FALLS INTO AN UNSAFE STATE');

              True:Begin
                   clrscr;
                   Writeln('AVAILABLE(MODIFIED)');
                   Writeln('------------------');
                   FOR I:=1 TO M DO
                    Write(Available[I]:3);
                    Writeln;


                   Writeln('MAX(MODIFIED)');
                   Writeln('------------');
                   FOR I:=1 TO N DO
                   Begin
                    Writeln;
                    FOR J:=1 TO M DO
                      Write(Max[I,J]:3);
                   end;
                   Writeln;


                   Writeln('ALLOCATION(MODIFIED)');
                   Writeln('-------------------');
                   FOR I:=1 TO N DO
                   Begin
                    Writeln;
                    FOR J:=1 TO M DO
                      Write(Max[I,J]:3);
                   end;
                   Writeln;


                   Writeln('NEED(MODIFIED)');
                   Writeln('-------------');
                   FOR I:=1 TO N DO
                   Begin
                    Writeln;
                    FOR J:=1 TO M DO
                      Write(Max[I,J]:3);
                   end;
                   end;

   end; {END OF CASE}
Readln;

end;
(******************************************************************************)
{PROCEDURE FileOut;
Begin

end;

PROCEDURE ScreenFileOut;
Begin

end;}
(******************************************************************************)
PROCEDURE Help(VAR HelpFile:Text);

VAR
 FileData:String;


Begin

I:=0;
clrscr;
WHILE NOT EOF(HelpFile) DO
Begin
 IF I=20 THEN
  Begin
   I:=0;
   Writeln('Press Any Key To Continue...');
   Readln;
   clrscr;
  end;
  I:=I+1;
  Readln(HelpFile,FileData);
 Writeln(FileData);
end;

end;
(******************************************************************************)

PROCEDURE CreateMenu(Selection:Char);
Begin

REPEAT
 clrscr;
 GotoXY(27,2);
 Writeln('COLLEGE SYS.');
 GotoXY(22,4);
 Writeln('BANKERS ALGORITHM GRAPHICAL SIMULATOR');
 GotoXY(22,5);
 Writeln('-------------------------------------');
 GotoXY(35,10);
 Writeln('MAIN MENU');
 GotoXY(35,11);
 Writeln('---------');
 GotoXY(30,12);
 Writeln('1.SEND OUTPUT TO SCREEN');
 GotoXY(30,14);
 Writeln('2.SEND OUTPUT TO FILE(BANKERS.RES)');
 GotoXY(30,16);
 Writeln('3.BOTH SCREEN AND FILE(BANKERS.RES');
 GotoXY(30,18);
 Writeln('4.PROGRAM HELP & COPYRIGHTS');
 GotoXY(30,20);
 Writeln('5.EXIT PROGRAM');
 GotoXY(30,23);
 Write('Please Make your Selection [ ]');
 GotoXY(58,23);
 Readln(Selection);

CASE Selection OF '1':Begin
                      clrscr;
                      ScreenOut;
                      BankersAlg1(Request,Need,PN);
                      end;
                  {'2':FileOut;
                  '3':ScreenFileOut;}
                  '4':Help(HelpFile);
  end;
UNTIL Selection='5';

end;

begin

Assign(Infile1,'Bankers.dat');
Reset(Infile1);
Assign(Infile2,'Request.dat');
Reset(Infile2);
Assign(Outfile,'Bankers.res');
Rewrite(Outfile);
Assign(HelpFile,'Heelp.txt');
Reset(HelpFile);
CreateMenu(Selection);

end.
