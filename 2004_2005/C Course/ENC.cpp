# include <stdio.h>
 main()
{
 char cha = ' ';
 char letter = ' ';
 int index =  0;
 int I = 0;
 char temp[2000];

 FILE * fp1;                      // Opens Input and Output Files
 FILE * fp2;
 fp2 = fopen("OUTFILE_1.cpp" ,"w" );
 if (( fp1 = fopen("INPUT.cpp" ,"r" )) == NULL )
  printf("Cannot open the file");


 
         
 index = 0;
 while ((letter = fgetc(fp1)) != EOF)
 {
   index++;
   I = index + 3;
   temp[index] = letter;
   if ((index % 2) == 0)
    temp[index] = temp[index] + ( ((I*3)-10) );
    else
   temp[index] = temp[index] + (index-2);
   fprintf(fp2,"%c",temp[index]);
   printf("%c",temp[index]);
 }

 scanf("%c",&cha);
 fclose(fp1);
 fclose(fp2);

 return(0);
}
