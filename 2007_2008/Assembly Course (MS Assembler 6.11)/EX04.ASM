Title Exercise4 Program (Ex04.asm)

.model small
.stack 100h
.data
Abytes1 db 10h,20h,30h,40h
Awords1 dw 0100h,0200h,0300h,0400h
Res1  db ?
Res2  dw ?
Res3  dw ?

.code
main proc
  mov ax,@data
  mov ds,ax

  mov ax,0000
  add al,Abytes1
  add al,Abytes1+1
  add al,Abytes1+2
  add al,Abytes1+3
  mov Res1,al

  mov ax,0000
  add ax,Awords1
  add ax,Awords1+2
  add ax,Awords1+4
  add ax,Awords1+6
  mov Res2,ax

  mov ax,0000
  mov al,Res1
  add ax,Res2
  mov Res3,ax







  mov ax,4C00h
  int 21h
main endp
end main