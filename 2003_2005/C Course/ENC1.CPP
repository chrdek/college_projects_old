
// ASSIGMENT 1 Encryption/Decryption of a text file in C

# include <stdio.h>
# include <conio.h>

 char sel = ' ';
 char cha = ' ';
 char letter = ' ';
 int index =  0;
 int I = 0;
 char temp[2000]; // temporary array to store the letters of the statment

void encode ()

{  FILE * fp1;                 //Declares fp1 as a pointer to the input file
   FILE * fp2;                 //Declares fp2 as a pointer to the output file
   fp2 = fopen("OUT1.cpp" ,"w" );                   // Open file in Write mode
   if (( fp1 = fopen("INPUT.cpp" ,"r" )) == NULL )  // Open file in Read mode
    printf("Cannot open the file");

   index = 0;
   while ((letter = fgetc(fp1)) != EOF)    // Algorithm used for Encryption
   {
    index++;
    I = index;
    temp[index] = letter;
    if ((index % 2) == 0)
     temp[index] = temp[index] + ( ((I*3)-10) );
    else
     temp[index] = temp[index] + (index-2);
    fprintf(fp2,"%c",temp[index]);        // Write encrypted output on file
    printf("%c",temp[index]);
   }
   fclose(fp1);   // Close input file
   fclose(fp2);   // Close  output file
   scanf("%c%c",&cha,&cha);
}


void decode ()  // Decodes the encrypted statment

{  FILE * fp1;                               //Declare pointers to the files
   FILE * fp2;
   fp2 = fopen("OUT2.cpp" ,"w" );                 // Open file in Write mode
   if (( fp1 = fopen("OUT1.cpp" ,"r" )) == NULL ) // in Read Mode
   printf("Cannot open the file");

   index = 0;
   while ((letter = fgetc(fp1)) != EOF)      // Algorithm for Decryptiom
    {
     index++;
     I = index;
     temp[index] = letter;
     if ((index % 2) == 0)
      temp[index] = temp[index] - ( ((I*3)-10) );
     else
      temp[index] = temp[index] - (index-2);
      fprintf(fp2,"%c",temp[index]);   // Writes the decoded statment on file
      printf("%c",temp[index]);        // Present it on screen
     }
    fclose(fp1);  // Close the files
    fclose(fp2);
    scanf("%c%c",&cha,&cha);
}

 main()
 {
  int out = 0;
  while (out == 0 )   // Repeats until out = 1
   { clrscr();
     printf("1. Encrypt File(INPUT.cpp)\n");   // Menu Options
     printf("\n");
     printf("2. Decrypt File(OUT1.cpp)\n");
     printf("\n");
     printf("3. EXIT PROGRAM...\n");
     printf("\n");
     printf("\n");
     printf("Please Make Your Selection:");
     scanf("%c",&sel);

     switch (sel) {
      case '1': encode();   // Encryption takes place
		break;

      case '2': decode();   // Decryption takes place
		break;

      case '3': out = 1;    // Exit the program
		 break;

		 }
   }
 scanf("%c%c",&cha,&cha);
 return(0);
}




