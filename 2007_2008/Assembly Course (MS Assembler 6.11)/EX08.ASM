Title (Ex08.asm)
.model small
.stack 100h

.data
array1 db 0,1,2,3,4,5,6,7,8,9
count = ($-array1)
var1 db 0
var2 db 0

.code
main proc
	
	mov ax,@data
	mov ds, ax
	mov ax, 0
	mov bx, 0
	mov cx,count

loop1:	
	add al, array1[bx]
	inc bx
	loop loop1
	
	mov var1, al
	mov al,array1[4]
	mov var2, al

	mov ax,4C00h
	int 21h
main endp
end main