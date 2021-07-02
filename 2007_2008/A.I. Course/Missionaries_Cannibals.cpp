/*                        Start Date: 16/11/2007                          */
/*------------------------------------------------------------------------*/
/*       Assignment #1 - Missionaries & Cannibals Problem                 */
/*------------------------------------------------------------------------*/
/* NOTE: The Program can compile but doesn't give the correct output yet  */
/*     It's filename extension is *.cpp but is in C source code not C++   */
/*           because i used DevC++ compiler to compile/run it.            */

#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
      
static int A_op[2],B_op[2],C_op[2],D_op[2],E_op[2],INIT[2],GOAL[2];
char j;

/* Structure of each data cell for both OPEN/CLOSED lists*/
struct cell {
       int Element[3];
       struct cell *next;
       };
       
/*Structure of front and rear element for both OPEN/CLOSED lists*/       
typedef struct HeadTail {
        struct cell *Front,*Rear;
        } Queue;

       

void Operators_Creator()
{ /*                        IN GENERAL:                      */
  /*  Element [0]=Missionaries number at left side of river  */
  /*  Element [1]=Cannibals number at left side of river     */
  /*  Element [2]=Boat number at left side of river (0 or 1) */
    
  A_op[0]= 1; A_op[1]= 0; A_op[2]= 1;   /* Operator (1,0,1) */
  
  B_op[0]= 0; B_op[1]= 1; B_op[2]= 1;   /* Operator (0,1,1) */
  
  C_op[0]= 2; C_op[1]= 0; C_op[2]= 1;   /* Operator (2,0,1) */
  
  D_op[0]= 0; D_op[1]= 2; D_op[2]= 1;   /* Operator (0,2,1) */
  
  E_op[0]= 1; E_op[1]= 1; E_op[2]= 1;   /* Operator (1,1,1) */
  
  
  /*    Define the initial state:         */ 
  /*   3 missionaries, 3 cannibals        */
  /*       on the left riverside          */
  /*  Boat at left side of river= 1       */
  INIT[0]= 3; INIT[1]= 3; INIT[2]= 1;   

  /*    Define the goal state:            */ 
  /*   0 missionaries, 0 cannibals        */
  /*       on the left riverside          */
  /*  Boat at left side of river= 0       */                                                                      
  GOAL[0]= 0; GOAL[1]= 0; GOAL[2]=0;    
 }



/*            "ENQUEUE" PROCEDURE          */
/*     Add a new element to the rear side  */
/*               of the queue              */
void Enqueue(cell **Front,cell **Rear,int arr[]) {

int k;
cell *newnode;

newnode= (cell *)malloc(sizeof(cell));
newnode->next= NULL;

for (k=0; k<=2; k++)
newnode->Element[k]= arr[k];

if(*Front==NULL && *Rear==NULL)
    {
        *Front=newnode;
        *Rear=newnode;
    }
    else
    {
    (*Rear)->next=newnode;
    *Rear=newnode;
    } 
}



/*            "DEQUEUE" PROCEDURE            */
/*     Remove an element from the front      */
/*               of the queue                */
void Dequeue(cell **Front,cell **Rear) {
     
cell *deleted;   

if (*Front==NULL && *Rear==NULL)
     {
     printf("Q EMPTY...cannot delete");  
     }
     else
     {
     deleted= *Front;
     (*Front)=(*Front)->next;
     free(deleted);
     }
}



/*   This function is used to make sure that the state of M < C    */
/*           dosen't occur at the other side of the river          */
/*             (while Boat number = 0 at the left side).           */
bool Check_Otherside(int TMP[]) {
     
int i;
     
for (i=0; i<=2; i++)
  TMP[i]= INIT[i] - TMP[i];
  
  if (TMP[0] < TMP[1] && TMP[0] != 0)
  return false;
  else 
  return true;
 }



/*  This function is used to search for a given element in a queue  */
/*            and return "True" if found, "False" otherwise.        */
/*              NOTE: This is not used in the program yet           
bool Locate(cell **Front,int X_State[]) {
 
int j; 
cell *current;

current= *Front; 
while ( current->next != NULL) {
      
    for (j=0; j<=2; j++)  
     if (current->Element[j] == X_State[j])
      return true;
      
  else current= current->next;    
   }
 return false;    
}*/



/*       This function is used for most validations in the program            */
/*                Cases for  M, C > 3 or M, C < 0 are checked                 */
/*   Also, case of M < C (except M = 0) for both sides of river are checked   */
bool Valid_Entry(int TEMPARRAY[]) {

int i,temp_check[2];
     
for (i=0; i<=2; i++)     
 temp_check[i]= TEMPARRAY[i];
     
if (temp_check[0] > 3 || temp_check[1] > 3  || temp_check[0] < 0 || temp_check[1] < 0)   
    return false;
        
else if (temp_check[0] < temp_check[1] && temp_check[0] != 0 || Check_Otherside(temp_check) == false)
    return false;

     else 
     return true; 
 }



/*     This procedure is used to subtract an operator given     */
/*               from a current element (state).                */
void Subtract_Op(int Q_Element[],int Any_Op[]) {
    
int w;   

for (w=0; w<=2; w++)
Q_Element[w]= Q_Element[w] - Any_Op[w];
}



/*   This procedure is used to add an operator given  */
/*          from a current element (state).           */
void Add_Op(int Q_Element[],int Any_Op[]) {
    
int w;   

for (w=0; w<=2; w++)
Q_Element[w]= Q_Element[w] + Any_Op[w];
}



/*                                */
/*    MAIN PROGRAM STARTS HERE    */
/*                                */
main()
{
      
int i,k,w;

/*  Temporary arrays required for verification of states generated  */      
int TMP_A[2],TMP_B[2],TMP_C[2],TMP_D[2],TMP_E[2];
int TMP1_A[2],TMP1_B[2],TMP1_C[2],TMP1_D[2],TMP1_E[2];

/*    Operators are created here (initialized with their values)    */
Operators_Creator();
printf("ALL OPERATORS ARE AS FOLLOWS:\n");
printf("-----------------------------\n");

for (i=0; i<=2; i++)
printf("%d",A_op[i]);
printf("\n");

for (i=0; i<=2; i++)
printf("%d",B_op[i]);
printf("\n");

for (i=0; i<=2; i++)
printf("%d",C_op[i]);
printf("\n");

for (i=0; i<=2; i++)
printf("%d",D_op[i]);
printf("\n");

for (i=0; i<=2; i++)
printf("%d",E_op[i]);
printf("\n");


Queue OPEN,CLOSED;

/*CREATE OPEN,CLOSED LIST*/
OPEN.Front= OPEN.Rear= NULL;
CLOSED.Front= CLOSED.Rear= NULL;

/*Insert the initial state (3,3,1) in OPEN */
Enqueue(&OPEN.Front,&OPEN.Rear,INIT);


printf("\n");
printf("THE INITIAL STATE IS:");
for (k=0; k<=2; k++)
printf("%d",OPEN.Rear->Element[k]);
printf("\n");

printf("THE FINAL STATE IS:");
for (k=0; k<=2; k++)
printf("%d",GOAL[k]);
printf("\n");



printf("\n");
printf("STATE SPACE AS FOLLOWS:");
printf("\n");


/*     State-Space Creator starts here     */
/*  NOTE: This doesn't work correctly yet  */
do {
    
/*  Beginning with boat number= 1 at the left riverside  */      
if (OPEN.Rear->Element[2] == 1) {
                          
/*    Insert each state already expanded into CLOSED list    */                          
Enqueue(&CLOSED.Front,&CLOSED.Rear,OPEN.Rear->Element);

for (i=0; i<=2; i++) {
TMP_A[i]= OPEN.Rear->Element[i];
TMP_B[i]= OPEN.Rear->Element[i];
TMP_C[i]= OPEN.Rear->Element[i];
TMP_D[i]= OPEN.Rear->Element[i];
TMP_E[i]= OPEN.Rear->Element[i];
}

Subtract_Op(TMP_A,A_op);
Subtract_Op(TMP_B,B_op);
Subtract_Op(TMP_C,C_op);
Subtract_Op(TMP_D,D_op);
Subtract_Op(TMP_E,E_op);

if (Valid_Entry(TMP_A)) {
 Enqueue(&OPEN.Front,&OPEN.Rear,TMP_A);
 for (k=0; k<=2; k++)
  printf("%d",TMP_A[k]);
  printf(" ");
} else;
 
if (Valid_Entry(TMP_B)) {
  Enqueue(&OPEN.Front,&OPEN.Rear,TMP_B);
  for (k=0; k<=2; k++)
  printf("%d",TMP_B[k]);
  printf(" ");
} else;

if (Valid_Entry(TMP_C)) {
  Enqueue(&OPEN.Front,&OPEN.Rear,TMP_C);
  for (k=0; k<=2; k++)
  printf("%d",TMP_C[k]);
  printf(" ");
} else;

if (Valid_Entry(TMP_D)) {
  Enqueue(&OPEN.Front,&OPEN.Rear,TMP_D);
  for (k=0; k<=2; k++)
  printf("%d",TMP_D[k]);
  printf(" ");
} else;

if (Valid_Entry(TMP_E)) {
  Enqueue(&OPEN.Front,&OPEN.Rear,TMP_E);
  for (k=0; k<=2; k++)
  printf("%d",TMP_E[k]);   
  printf(" ");
 } else;

/*  Remove already expanded state from OPEN list  */ 
Dequeue(&OPEN.Front,&OPEN.Rear);
}


/*  Beginning with boat number= 0 at the left riverside  */
else if (OPEN.Rear->Element[2] == 0) {
     
/*    Insert each state already expanded into CLOSED list    */                          
Enqueue(&CLOSED.Front,&CLOSED.Rear,OPEN.Rear->Element);

for (i=0; i<=2; i++) {
TMP1_A[i]= OPEN.Rear->Element[i];
TMP1_B[i]= OPEN.Rear->Element[i];
TMP1_C[i]= OPEN.Rear->Element[i];
TMP1_D[i]= OPEN.Rear->Element[i];
TMP1_E[i]= OPEN.Rear->Element[i];
}

Add_Op(TMP1_A,A_op);
Add_Op(TMP1_B,B_op);
Add_Op(TMP1_C,C_op);
Add_Op(TMP1_D,D_op);
Add_Op(TMP1_E,E_op);

if (Valid_Entry(TMP1_A)) {
 Enqueue(&OPEN.Front,&OPEN.Rear,TMP1_A);
 for (k=0; k<=2; k++)
  printf("%d",TMP1_A[k]);
  printf(" ");
} else;
 
if (Valid_Entry(TMP1_B)) {
  Enqueue(&OPEN.Front,&OPEN.Rear,TMP1_B);
  for (k=0; k<=2; k++)
  printf("%d",TMP1_B[k]);
  printf(" ");
} else;

if (Valid_Entry(TMP1_C)) {
  Enqueue(&OPEN.Front,&OPEN.Rear,TMP1_C);
  for (k=0; k<=2; k++)
  printf("%d",TMP1_C[k]);
  printf(" ");
} else;

if (Valid_Entry(TMP1_D)) {
  Enqueue(&OPEN.Front,&OPEN.Rear,TMP1_D);
  for (k=0; k<=2; k++)
  printf("%d",TMP1_D[k]);
  printf(" ");
} else;

if (Valid_Entry(TMP1_E)) {
  Enqueue(&OPEN.Front,&OPEN.Rear,TMP1_E);
  for (k=0; k<=2; k++)
  printf("%d",TMP1_E[k]);   
  printf(" ");
 } else;
 
/*  Remove already expanded state from OPEN list  */ 
Dequeue(&OPEN.Front,&OPEN.Rear);
}

}/*  Continue generating states until goal is reached (state 0,0,0)  */
while (OPEN.Rear->Element[0] != GOAL[0] && OPEN.Rear->Element[1] != GOAL[1] &&
OPEN.Rear->Element[2] != GOAL[2]);
/*                                   */
/*     THIS PART IS NOT FINISHED     */
/*                                   */

scanf("%c",&j);
      }
