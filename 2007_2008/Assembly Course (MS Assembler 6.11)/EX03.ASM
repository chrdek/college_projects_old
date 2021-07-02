Title(Ex03.asm)
;This program displays "Hello Hello Hello and more !!!!"
.model small
.stack 100h
.data
message db "Hello Hello Hello and more !!!!",0dh,0ah,'$'
rloop1 db ?
rloop2 db ?
rloop3 db ?
value1 db 0Ah
value2 db 14h
value3 dw 2233h
value4 dw 4455h
bList db 10h,20h,30h,40h
addLb db ?
wList dw 1000h,2000h,3000h
addLw dw ?

.code
main proc
	mov ax,@data
	mov ds,ax
	
	mov ah,9
	mov dx,offset message
	int 21h

	mov ax,0
	mov cx,4
	top1:
	inc ax
	loop top1
	mov rloop1,al

	mov ax,2*2
	mov cx,3
	top2:
	inc ax
	loop top2
	mov rloop2,al

	mov ax,18/2
	mov cx,5
	top3:
	dec ax
	loop top3
	mov rloop3,al

	mov ax,31 mod 6
	mov ax,22 mod 5
	mov ax,49 mod 9

	count=15
	mov ax,"2"-30h
	mov ax,1000h*50h
	mov ax,count+2
	mov ax,count*8/4
	mov al,value1
	xchg al,value2
	mov value1,al

	mov ax,value3
	xchg ax,value4
	mov value3,ax

	mov ax,0
	mov di,offset bList
	add al,byte ptr[di]
	inc di
	add al,byte ptr[di]
	inc di
	add al,byte ptr[di]
	inc di
	add al,byte ptr[di]
	mov addLb,al

	mov ax,0
	mov bx,offset wList
	add ax,word ptr[bx]
	add bx,2
	add ax,word ptr[bx]
	add bx,2
	add ax,word ptr[bx]
	mov addLw,ax

	mov ax,4C00h
	int 21h
main endp
end main