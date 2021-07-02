==================================================================================
                                                                                    
Compilers Project: A Flex/Bison-based calculator for simple arithmetic expressions
                                                                                 
==================================================================================


Purpose of Project:
-------------------
The initial problem was to construct a language translator of a simple infix notation calculator
using automated tools like lex/flex (lexical analyzer generators) and yacc/bison (parser generators).
The calculator should support all simple mathematic operators like '+''-''*''/',
relational operators like '<' '>' '==' '!=', parentheses to override precedence,
assignment of (integer) values in single charcater variables and some 
standard mathematical functions like root, power etc.


Programming Language/Tools:
---------------------------
I used GNU win32 flex (flex v2.5.4a-1) and GNU win32 bison (bison v2.1) along with
Bloodshed DevCpp v4.9.9.2 Compiler(C/C++ compiler).


Operating System:
-----------------
Microsoft Windows XP Professional
Version 2002
Service Pack 2


Detailed Installation/Run Instructions:
---------------------------------------
First, you'll need to download both flex and bison win32 versions.
You can find the following setup files here: http://gnuwin32.sourceforge.net/packages.html
flex-2.5.4a-1.exe
bison-2.1.exe

Install each file to their initial directories given by the setup.They should both be 
installed under "C:\Program Files\GnuWin32". Copy and paste the whole contents of this directory
in your C compiler root directory (Whether it is Visual C++ or DevC++ etc...). For example,
I copied them in "C:\Dev-Cpp" and replaced any similar folders (such as bin).
Then, move the *.y and *.l files in the directory where the compiler's executable is 
found (gcc.exe usually in \bin).

Two batch files are also provided with the sources with which the bison, flex
files can be compiled/linked. To use my batch files follow this procedure:

- Open file "Runbison.txt" and change the "SET PATH=" to the path of your own compiler.
  Then save file as "Runbison.bat" where you prefer (you may also delete the -v option
  if you want as it's not necessary for it to work).

- Open file "Runflex.txt" and change the "SET PATH=" to the path of your own compiler.
  Then save file as "Runflex.bat" where you prefer.

-Run "Runbison.bat" to compile the *.y file.
-Run "Runflex.bat" to compile/link the *.l file and create the executable.

Finally, go to the \bin directory that you saved the *.y and *.l files in and run the executable file
that has the same name as those two files.


Date: 10/01/08

