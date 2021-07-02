PROGRAM ColourSel;

(*************************************************************)
(***  Graphics Assignment #1: A Colours Selection Program  ***)
(***                                                       ***)
(***                                                       ***)
(***  Year: 2004-2005                                      ***)
(***                                                       ***)
(***  Start Date: 17/11/2004                               ***)
(*************************************************************)


USES
 CRT,DOS,GRAPH;

CONST
 colornum=15;

TYPE
 Animcolors=1..colornum; (* Exclude black color during startup animation *)
 Allcolors=0..colornum;  (* Include all colors in "PLAY" selection *)

 ColRecord = RECORD
             Boxcolor:Allcolors;
             Active:Boolean;
            end;

 ColMatrix = ARRAY [Allcolors] OF ColRecord;

VAR
 resx,resy:integer;
 graphdriver,graphmode,errorcode,currentmode:integer;
 X,Y:integer;
 I:integer;
 Colors,Defaultcol:Allcolors;
 ColorArray:ColMatrix;
 Noblack:Animcolors;
 driverpath:String;
 Sel,Ch,DrawType:Char;
 Points,Correct,Wrong,GameNum:integer;
(******************************************************************************)
PROCEDURE findresolution;

Begin

resx:=1;
resy:=1;

end;
(****************************************************************************)
PROCEDURE Initialize;

Begin

Graphdriver:=9;
initgraph(graphdriver,graphmode,driverpath); (* Initialize the resolution *)
errorcode:=graphresult;                     (* of the system. Set graphmode *)
  If errorcode=grOK Then                   (* as 1 (Make 2 pages available) *)
   findresolution
     else
    Begin
     closegraph;
     Writeln('Graphics Card Error:',Grapherrormsg(errorcode));
    end;
  currentmode:=getgraphmode;

end;
(****************************************************************************)
PROCEDURE MovingObj;

Begin

  setcolor(Noblack);
  setfillstyle(solidfill,Noblack);
  circle(X,Y,60);
  floodfill(X,Y,Noblack);
  Delay(90);
  setcolor(black);
  setfillstyle(solidfill,black);
  circle(X,Y,60);
  floodfill(X,Y,black);

end;
(****************************************************************************)
PROCEDURE PlayBtn;

Begin

bar(40,90,120,110);
outtextxy(65,97,'PLAY');

end;
(****************************************************************************)
PROCEDURE HelpBtn;

Begin

bar(40,120,120,140);
outtextxy(65,127,'HELP');

end;
(****************************************************************************)
PROCEDURE ExitBtn;

Begin

bar(40,150,120,170);
outtextxy(65,157,'EXIT');

end;
(****************************************************************************)
FUNCTION ConvInt(VAR number:integer):String;

VAR
 StrOut:String[10];

Begin

str(number,StrOut);
ConvInt:=StrOut;

end;
(****************************************************************************)
FUNCTION CheckChr(VAR key:Char):Char;

Begin

   IF (key=#0) and keypressed THEN           (* Function used to verify *)
    key:=Readkey;                            (* whether you have pressed *)
                                           (* the Up,Down,Left,or Right key *)
  CASE ord(key) OF 80:CheckChr:='D';
                   72:CheckChr:='U';
                   77:CheckChr:='R';
                   75:CheckChr:='L';
                 end;

end;
(****************************************************************************)
PROCEDURE Sel4;

Begin

bar(70,160,150,190);
Rectangle(70,160,150,190);
outtextxy(105,170,'4');

end;
(****************************************************************************)
PROCEDURE Sel8;

Begin

bar(150,160,230,190);
Rectangle(150,160,230,190);
outtextxy(185,170,'8');

end;
(****************************************************************************)
PROCEDURE Sel16;

Begin

bar(230,160,310,190);
Rectangle(230,160,310,190);
outtextxy(265,170,'16');

end;
(****************************************************************************)
PROCEDURE Drawing1;

Begin

circle(X+7,Y+7,0);
circle(X+7,Y+7,5);
circle(X+7,Y+7,10);

end;
(****************************************************************************)
PROCEDURE Drawing2;

Begin

line(X,Y,X+35,Y+15);
line(X,Y+15,X+35,Y);

end;
(****************************************************************************)
PROCEDURE Drawing3;

Begin

circle(X+7,Y+7,10);
line((X+7)+10,Y+7,(X+7)-10,Y+7);

end;
(****************************************************************************)
PROCEDURE Drawing4;

VAR
 PrevX,PrevY:integer;

Begin

PrevX:=X;
PrevY:=Y;
line((X+7)+28,Y+7,(X+7)-7,Y+7);
line((X+7)+10,(Y+7)-7,(X+7)+10,(Y+7)+8);
line(PrevX,PrevY,PrevX+35,PrevY+15);
line(PrevX,PrevY+15,PrevX+35,PrevY);

end;
(****************************************************************************)
PROCEDURE Box1;

Begin

bar(70,20,105,35);
Rectangle(70,20,105,35);
X:=80;
Y:=20;
Drawing1;

end;
(****************************************************************************)
PROCEDURE Box2;

Begin

bar(120,20,155,35);
Rectangle(120,20,155,35);
X:=120;
Y:=20;
Drawing2;

end;
(****************************************************************************)
PROCEDURE Box3;

Begin

bar(70,50,105,65);
Rectangle(70,50,105,65);
X:=80;
Y:=50;
Drawing3;

end;
(****************************************************************************)
PROCEDURE Box4;

Begin

bar(120,50,155,65);
Rectangle(120,50,155,65);
X:=120;
Y:=50;
Drawing4;

end;
(****************************************************************************)
PROCEDURE SelBox;

Begin

Rectangle(X,Y,X+35,Y+15);

end;
(****************************************************************************)
PROCEDURE Checkactive;

Begin

IF ColorArray[I].Active <> True THEN
Begin
 setcolor(white);
 outtextxy(350,150,'Box already selected...select again');
 Delay(900);
 setcolor(black);
 outtextxy(350,150,'Box already selected...select again');
end;

end;
(****************************************************************************)
PROCEDURE Checkcol;

Begin

CASE Readkey OF chr(13):Begin
                         Checkactive;
                        IF ColorArray[I].Boxcolor = Defaultcol THEN
                         Begin
                           IF ColorArray[I].Boxcolor = 0 THEN
                           setcolor(white)
                            ELSE
                           setcolor(black);
                           CASE DrawType OF '1':Drawing1;
                                            '2':Drawing2;
                                            '3':Drawing3;
                                            '4':Drawing4;
                          end;
                          ColorArray[I].Active:=False;
                          Points:=Points+10;
                          Correct:=Correct+1;
                         end

ELSE IF(ColorArray[I].Boxcolor <> Defaultcol) and (ColorArray[I].Active = True) THEN
                       Begin
                        setcolor(white);
                        outtextxy(350,150,'Wrong color selected, -10 points');
                        Delay(900);
                        setcolor(black);
                        outtextxy(350,150,'Wrong color selected, -10 points');
                        ColorArray[I].Active:=False;
                        Points:=Points-10;
                        Wrong:=Wrong+1;
                       end;
                      end;
                    end; (* END OF CASE *)
end;
(****************************************************************************)
PROCEDURE DrawStep3;

VAR
 exit:Boolean;

Begin

Randomize;                                        (* Begin Step3: *)
Defaultcol:=Random(Colors);
FOR I:=0 TO colornum DO
Begin
 ColorArray[I].Boxcolor:=Random(Colors);    (* Random initialization of *)
 ColorArray[I].Active:=True;                   (*   the color array   *)
end;


X:=0;
Y:=0;
FOR I:=0 TO colornum DO
Begin
setfillstyle(solidfill,ColorArray[I].Boxcolor);     (* Random creation of *)
 IF ColorArray[I].Boxcolor = 0 THEN                   (* the color table *)
 Rectangle(400+X,5+Y,435+X,20+Y)
  ELSE
 bar(400+X,5+Y,435+X,20+Y);
 X:=X+50;
 IF (I = 3) OR (I = 7) OR (I = 11) THEN
  Begin
   Y:=Y+30;
   X:=0;
  end;
end;

X:=400;
Y:=5;
setcolor(yellow);
SelBox;
I:=0;
exit:=false;

repeat

setcolor(white);
outtextxy(350,125,'3. Find color');                 (* A randomly selected *)
setfillstyle(solidfill,Defaultcol);                   (* color as default *)
 IF Defaultcol = 0 THEN
 Rectangle(480,120,515,135)
  ELSE
 bar(480,120,515,135);
outtextxy(530,125,'in the array');
outtextxy(350,165,'Press "ESC" to return to main...');

   Ch:=Readkey;
IF Ch = chr(27) THEN
  exit:=true;

  CASE CheckChr(Ch) OF 'R':Begin
   (* Begin Movement *)     IF (I <> 3) and (X <> 550) THEN
   (* Procedure in the *)   Begin
      (* color table *)      IF ColorArray[I].Boxcolor = 0 THEN
                             setcolor(white)
                              ELSE
                             setcolor(black);
                             SelBox;
                             X:=X+50;
                             setcolor(yellow);
                             SelBox;
                             I:=I+1;
                            end;
                            Checkcol;
                           end;



                       'L':Begin
                            IF (I <> 0) and (X <> 400) THEN
                            Begin
                             IF ColorArray[I].Boxcolor = 0 THEN
                             setcolor(white)
                              ELSE
                             setcolor(black);
                             SelBox;
                             X:=X-50;
                             setcolor(yellow);
                             SelBox;
                             I:=I-1;
                            end;
                            Checkcol;
                           end;



                       'U':Begin
                            IF (I <> 3) and (Y <> 5) THEN
                            Begin
                             IF ColorArray[I].Boxcolor = 0 THEN
                             setcolor(white)
                              ELSE
                             setcolor(black);
                             SelBox;
                             Y:=Y-30;
                             setcolor(yellow);
                             SelBox;
                             I:=I-4;
                            end;
                            Checkcol;
                           end;



                       'D':Begin
                            IF (I <> 15) and (Y <> 95) THEN
                            Begin
                             IF ColorArray[I].Boxcolor = 0 THEN
                             setcolor(white)
                              ELSE
                             setcolor(black);
                             SelBox;
                             Y:=Y+30;
                             setcolor(yellow);
                             SelBox;
                             I:=I+4;
                            end;
                            Checkcol;
                           end;
                      end;
until exit = true;

end;
(****************************************************************************)
PROCEDURE DrawStep2;

Begin

outtextxy(70,5,'2. Select your drawing:');(* Step2 of the "PLAY" procedure. *)
setfillstyle(solidfill,red);             (* Select a pattern to draw in the *)
bar(70,20,105,35);                              (* correct color box. *)
Box1;
setfillstyle(solidfill,black);
Box2;
Box3;
Box4;

Sel:='1';
repeat

   Ch:=Readkey;
  CASE CheckChr(Ch) OF 'R':Begin
                             IF (CheckChr(Ch) = 'R') and (Sel = '1') THEN
                             Begin
                              setfillstyle(solidfill,black); (* Move Right *)
                              Box1;
                              setfillstyle(solidfill,red);
                              Box2;
                              Sel:='2';
                             end

                             ELSE IF (CheckChr(Ch) = 'L') and (Sel = '2') THEN
                               Begin
                                setfillstyle(solidfill,black);
                                Box2;
                                setfillstyle(solidfill,red);
                                Box1;
                                Sel:='1';
                               end;
                             end;

                       'L':Begin
                            IF (CheckChr(Ch) = 'L') and (Sel = '2') THEN
                              Begin
                               setfillstyle(solidfill,black);(* Move Left *)
                               Box2;
                               setfillstyle(solidfill,red);
                               Box1;
                               Sel:='1';
                              end

                            ELSE IF (CheckChr(Ch) = 'R') and (Sel = '1') THEN
                             Begin
                              setfillstyle(solidfill,black);
                              Box1;
                              setfillstyle(solidfill,red);
                              Box2;
                              Sel:='2';
                             end;
                            end;

                       'U':Begin
                             IF (CheckChr(Ch) = 'U') and (Sel = '3') THEN
                             Begin
                              setfillstyle(solidfill,black); (* Move Up *)
                              Box3;
                              setfillstyle(solidfill,red);
                              Box1;
                              Sel:='1';
                             end

                             ELSE IF (CheckChr(Ch) = 'U') and (Sel = '4') THEN
                               Begin
                                setfillstyle(solidfill,black);
                                Box4;
                                setfillstyle(solidfill,red);
                                Box2;
                                Sel:='2';
                               end;
                             end;


                       'D':Begin
                            IF (CheckChr(Ch) = 'D') and (Sel = '1') THEN
                              Begin
                               setfillstyle(solidfill,black); (* Move Down *)
                               Box1;
                               setfillstyle(solidfill,red);
                               Box3;
                               Sel:='3';
                               Ch:=Readkey;


  CASE CheckChr(Ch) OF 'R':Begin
                             IF (CheckChr(Ch) = 'R') and (Sel = '3') THEN
                             Begin
                              setfillstyle(solidfill,black); (* Move Right *)
                              Box3;
                              setfillstyle(solidfill,red);
                              Box4;
                              Sel:='4';
                             end

                             ELSE IF (CheckChr(Ch) = 'L') and (Sel = '4') THEN
                               Begin
                                setfillstyle(solidfill,black);
                                Box4;
                                setfillstyle(solidfill,red);
                                Box3;
                                Sel:='3';
                               end;
                             end;

                       'L':Begin
                            IF (CheckChr(Ch) = 'L') and (Sel = '4') THEN
                              Begin
                               setfillstyle(solidfill,black);(* Move Left *)
                               Box4;
                               setfillstyle(solidfill,red);
                               Box3;
                               Sel:='3';
                              end

                            ELSE IF (CheckChr(Ch) = 'R') and (Sel = '3') THEN
                             Begin
                              setfillstyle(solidfill,black);
                              Box3;
                              setfillstyle(solidfill,red);
                              Box4;
                              Sel:='4';
                             end;
                            end;
                           end;
                          end

                            ELSE IF (CheckChr(Ch) = 'D') and (Sel = '2') THEN
                             Begin
                              setfillstyle(solidfill,black);
                              Box2;
                              setfillstyle(solidfill,red);
                              Box4;
                              Sel:='4';
                              Ch:=Readkey;


  CASE CheckChr(Ch) OF 'R':Begin
                             IF (CheckChr(Ch) = 'R') and (Sel = '3') THEN
                             Begin
                              setfillstyle(solidfill,black); (* Move Right *)
                              Box3;
                              setfillstyle(solidfill,red);
                              Box4;
                              Sel:='4';
                             end

                             ELSE IF (CheckChr(Ch) = 'L') and (Sel = '4') THEN
                               Begin
                                setfillstyle(solidfill,black);
                                Box4;
                                setfillstyle(solidfill,red);
                                Box3;
                                Sel:='3';
                               end;
                             end;

                       'L':Begin
                            IF (CheckChr(Ch) = 'L') and (Sel = '4') THEN
                              Begin
                               setfillstyle(solidfill,black);(* Move Left *)
                               Box4;
                               setfillstyle(solidfill,red);
                               Box3;
                               Sel:='3';
                              end

                            ELSE IF (CheckChr(Ch) = 'R') and (Sel = '3') THEN
                             Begin
                              setfillstyle(solidfill,black);
                              Box3;
                              setfillstyle(solidfill,red);
                              Box4;
                              Sel:='4';
                             end;
                            end;
                           end;
                           end;
                           end;
                          end;
until Ch = chr(13);

CASE Sel OF '1':DrawType:='1';
            '2':DrawType:='2';
            '3':DrawType:='3';
            '4':DrawType:='4';
           end;

DrawStep3;

end;
(****************************************************************************)
PROCEDURE DrawStep1;

Begin

setcolor(white);
outtextxy(70,145,'1. Select the number of colors:');
setlinestyle(solidln,0,normwidth);        (* Step1 of the "PLAY" procedure. *)
setfillstyle(solidfill,red);               (* Select the range of colors to *)
bar(70,160,150,190);                       (* be randomly selected for the *)
Rectangle(70,160,150,190);                    (* color table at step 3. *)
outtextxy(105,170,'4');
Rectangle(150,160,230,190);
outtextxy(185,170,'8');
Rectangle(230,160,310,190);
outtextxy(265,170,'16');

Sel:='1';
repeat

   Ch:=Readkey;
  CASE CheckChr(Ch) OF 'R':Begin
                             IF (CheckChr(Ch) = 'R') and (Sel = '1') THEN
                             Begin
                              setfillstyle(solidfill,black); (* Move Right *)
                              Sel4;
                              setfillstyle(solidfill,red);
                              Sel8;
                              Sel:='2';
                             end

                             ELSE IF (CheckChr(Ch) = 'R') and (Sel = '2') THEN
                               Begin
                                setfillstyle(solidfill,black);
                                Sel8;
                                setfillstyle(solidfill,red);
                                Sel16;
                                Sel:='3';
                               end;
                             end;

                       'L':Begin
                            IF (CheckChr(Ch) = 'L') and (Sel = '3') THEN
                              Begin
                               setfillstyle(solidfill,black);(* Move Left *)
                               Sel16;
                               setfillstyle(solidfill,red);
                               Sel8;
                               Sel:='2';
                              end

                            ELSE IF (CheckChr(Ch) = 'L') and (Sel = '2') THEN
                             Begin
                              setfillstyle(solidfill,black);
                              Sel8;
                              setfillstyle(solidfill,red);
                              Sel4;
                              Sel:='1';
                             end;
                            end;
                          end;
until Ch = chr(13);

CASE Sel OF '1':Colors:=4;
            '2':Colors:=8;
            '3':Colors:=colornum;
           end;

DrawStep2;

end;
(****************************************************************************)
PROCEDURE Play;

Begin

Points:=0;
Correct:=0;
Wrong:=0;
GameNum:=GameNum+1;
cleardevice;                            (* Begin "PLAY" procedure *)
setactivepage(0);                      (* All 3 steps are activated *)
setvisualpage(0);                              (* from here *)
DrawStep1;

end;
(****************************************************************************)
PROCEDURE Help;

Begin

repeat

setactivepage(1);
setvisualpage(1);
setcolor(white);
outtextxy(200,5,'HELP OPTION FOR COLOR GAME');
outtextxy(200,10,'--------------------------');
outtextxy(20,30,'1. A BRIEF EXPLANATION OF THE COLOR GAME:');
outtextxy(20,40,'At first, you select the number of different colors (4,8,16)');
outtextxy(20,50,'and then a preferred shape from among 4 different shapes');
outtextxy(20,60,'to choose from. Then a color table is randomly created based');
outtextxy(20,70,'on the selection of the number of colors that you have made.');
outtextxy(20,80,'Also another color is selected in random and this will be the');
outtextxy(20,90,'default color you will need to find on the table. When a correct');
outtextxy(20,100,'color is found, then your selected drawing will appear on the');
outtextxy(20,110,'selected color box. Scoring is based on the selections made. (+10,-10 points)');
outtextxy(20,120,'2. MOVEMENT/SELECTION KEYS:');
outtextxy(20,130,'--> Use the right arrow to move right');
outtextxy(20,140,'<-- Use the left arrow to move left');
outtextxy(20,150,'/\ Use the up arrow to move up');
outtextxy(20,160,'\/ Use the down arrow to move down');
outtextxy(20,170,'Use the ENTER key to make a selection (Menus/Table)');
outtextxy(20,180,'Use the ESC key to reset a current game session');
outtextxy(20,190,'Press ANY key to view score stats...');

until keypressed;

cleardevice;
outtextxy(20,30,'3. SCORING/RESULTS:');
outtextxy(20,40,'Total points of session:'+ConvInt(Points));
outtextxy(20,60,'Total of correct answers:'+ConvInt(Correct));
outtextxy(20,80,'Total of wrong answers:'+ConvInt(Wrong));
outtextxy(20,100,'Total number of sessions:'+ConvInt(GameNum));
outtextxy(20,140,'PRESS THE ESC KEY TO RETURN TO MAIN MENU...');
repeat until Readkey = chr(27);

end;
(****************************************************************************)
PROCEDURE Menu;

Begin

Sel:='1';
repeat

   Ch:=Readkey;
  CASE CheckChr(Ch) OF 'D':Begin
                             IF (CheckChr(Ch) = 'D') and (Sel = '1') THEN
                             Begin
                              setcolor(white);      (* Move Selection Down *)
                              PlayBtn;
                              setcolor(yellow);
                              HelpBtn;
                              Sel:='2';
                             end

                             ELSE IF (CheckChr(Ch) = 'D') and (Sel = '2') THEN
                               Begin
                                setcolor(white);
                                HelpBtn;
                                setcolor(yellow);
                                ExitBtn;
                                Sel:='3';
                               end;
                             end;

                       'U':Begin
                            IF (CheckChr(Ch) = 'U') and (Sel = '3') THEN
                              Begin
                               setcolor(white);      (* Move Selection Up *)
                               ExitBtn;
                               setcolor(yellow);
                               HelpBtn;
                               Sel:='2';
                              end

                            ELSE IF (CheckChr(Ch) = 'U') and (Sel = '2') THEN
                             Begin
                              setcolor(white);
                              HelpBtn;
                              setcolor(yellow);
                              PlayBtn;
                              Sel:='1';
                             end;
                            end;
                          end;
until Ch = chr(13);

CASE Sel OF '1':Play;
            '2':Help;
            '3':end;

end;
(****************************************************************************)
PROCEDURE Startup;

VAR
CheckXY:Char;
I,TmpX1,TmpX2,TmpY:integer;

Begin

clrscr;

Initialize;
setactivepage(0);
setvisualpage(0);
X:=30;
Y:=100;
WHILE X<=400 DO
 Begin
 MovingObj;
  IF X IN [30..80,130..180] THEN
    CheckXY:='0'

  ELSE IF X IN [80..130,180..230] THEN
    CheckXY:='1';


   CASE CheckXY OF '0':Y:=Y+5;  (* Move Object Down *)

                   '1':Y:=Y-5;  (* Move Object Up *)
              end;
  X:=X+5;
  Noblack:=Noblack+1;
 end;

  setcolor(yellow);
  setfillstyle(solidfill,yellow);
  circle(X,Y,60);
  floodfill(X,Y,yellow);

  Delay(1000);
  setcolor(black);
  setfillstyle(solidfill,black);
  FOR I:=1 TO 10 DO
  Begin
   Delay(70);
   circle(X+25,Y-10,I);
   floodfill(X+25,Y-10,black);
  end;

  setfillstyle(solidfill,black);
  FOR I:=1 TO 10 DO
  Begin
   Delay(70);
   circle(X-25,Y-10,I);
   floodfill(X-25,Y-10,black);
  end;

  Setlinestyle(solidln,0,thickwidth);
  line(X+2,Y-7,X+2,Y+6);
  FOR I:=1 TO 15 DO
  Begin
   Delay(70);
   ellipse(X,Y+10,180,360,I+6,I);
  end;

  setcolor(yellow);
  X:=300;
  Y:=30;
  FOR I:=1 TO 280 DO
  Begin
   Delay(10);
   line(X+I,Y,X-I,Y);
   TmpX1:=X+I;
   TmpX2:=X-I;
  end;

  FOR I:=1 TO 160 DO
  Begin
   Delay(10);
   line(TmpX2,Y,TmpX2,Y+I);
   line(TmpX1,Y,TmpX1,Y+I);
   TmpY:=Y+I;
  end;

  FOR I:=1 TO 280 DO
  Begin
   Delay(10);
   line(TmpX2+I,TmpY,TmpX2+I,TmpY);
   line(TmpX1-I,TmpY,TmpX1-I,TmpY);
  end;

  X:=100;
  Y:=40;

  setcolor(9);
  settextstyle(sansseriffont,horizdir,4);
  Delay(200);
  outtextxy(X,Y,'T');
  Delay(200);
  outtextxy(X+40,Y,'H');
  Delay(200);
  outtextxy(X+80,Y,'E');

  X:=140;
  Y:=80;
  FOR I:=1 TO 9 DO
  Begin
   setcolor(I);
   Delay(70);
   settextstyle(sansseriffont,horizdir,I);
   outtextxy(X,Y,'Colour');
  end;

  X:=450;
  Y:=120;
  FOR I:=1 TO 9 DO
  Begin
   setcolor(I);
   settextstyle(sansseriffont,horizdir,5);
   Delay(100);
   outtextxy(X,Y,'GAME');
  end;


  setfillstyle(solidfill,red);
  setcolor(yellow);
  settextstyle(defaultfont,horizdir,1);
  Delay(300);
  PlayBtn;
  setcolor(white);
  Delay(300);
  HelpBtn;
  Delay(300);
  ExitBtn;
  Menu;  { <--DRAW THE VISUAL MENU TO SELECT OPTIONS FROM HERE }

end;
(****************************************************************************)
Begin (* Of Main Program *)

repeat
Startup;
until Sel='3';

end.






















