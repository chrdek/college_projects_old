Title Exercise 5 Program (ex05.asm)

.model small
.stack 100h
.data
Abytes1 db 10h,20h,30h,40h
Awords1 dw 0100h,0200h,0300h,0400h
Res1a db ?
Res1b db ?
Res2a dw ?
Res2b dw ?
Res3  dw ?

.code
main proc
  mov ax,@data
  mov ds,ax

;PART A:
;-------
  mov ax,0000
  mov di,offset Abytes1
  add al,byte ptr [di]
  inc di
  add al, byte ptr [di]
  inc di
  add al, byte ptr [di]
  inc di
  add al, byte ptr [di]
  mov Res1a,al

;PART B:
;-------
  mov ax,0000
  mov di,offset Abytes1
  mov cx,4
  chris1:
  add al,byte ptr [di]
  inc di
  loop chris1
  mov Res1b,al

;PART C:
;-------
  mov ax,0000
  mov di,offset Awords1
  add ax,word ptr [di]
  add di,2
  add ax, word ptr [di]
  add di,2
  add ax, word ptr [di]
  add di,2
  add ax word ptr [di]
  mov Res2a,ax

;PART D:
;-------
  mov ax,0000
  mov di,offset Awords1
  mov cx,4
  chris1:
  add al,byte ptr [di]
  add di,2
  loop chris1
  mov Res2b,ax

;PART E:
;-------
  mov ax,0000
  mov al,Res1a
  add ax,Res2b
  mov Res3,ax

  mov ax,4C00h
  int 21h

main endp
main