Title Hello World Program(Ex02.asm)
;This program displays "Hello, world!"
.model small
.stack 100h
.data
message db "Hello, world!",0dh,0ah,'$'
byte1	db ?
byte2	db ?
byte3	db ?
byte4	db ?
byte41	db ?
byte42	db ?
byte5	db 4 dup(2)
byte6	db 6 dup(3)
word1	dw 4 dup(4)
string1 db 4 dup("A")
string2 db 4 dup(41h)

.code
main proc
	mov ax,@data
	mov ds,ax

	mov ah,9
	mov dx,offset message
	int 21h

	mov ax,0
	add al,message+1
	mov byte1,al

	mov ax,1
	add al,message+2
	mov byte2,al

	mov ax,2
	add al,message+4
	mov byte3,al
	
	mov al,message+5
	add al,message+6
	mov byte4,al

	mov al,string1-1
	mov byte41,al
	mov al,string1-2
	mov byte42,al

	mov ax,4C00h
	int 21h
main endp
end main

