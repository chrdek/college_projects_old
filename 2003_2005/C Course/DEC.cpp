# include <stdio.h>
 main()
{
 char cha = ' ';
 char letter = ' ';
 int index =  0;
 int I = 0;
 char temp[2000];
 
 FILE * fp1;       //Open input file
 FILE * fp2;      //Open output file
 fp2 = fopen("OUTFILE_2.cpp" ,"w" );
 if (( fp1 = fopen("OUTFILE_1.cpp" ,"r" )) == NULL )
  printf("Cannot open the file");



   
 index = 0;
 fprintf(fp2,"The Decrypted data is:\n");
 while ((letter = fgetc(fp1)) != EOF)
 {
   index++;
   I = index + 3;
   temp[index] = letter;
   if ((index % 2) == 0)
    temp[index] = temp[index] - ( ((I*3)-10) );
    else
   temp[index] = temp[index] - (index-2);
   fprintf(fp2,"%c",temp[index]);
 }
 
 printf("File Successfully Decrypted...");
 scanf("%c",&cha);
 fclose(fp1);
 fclose(fp2);

 return(0);
}
