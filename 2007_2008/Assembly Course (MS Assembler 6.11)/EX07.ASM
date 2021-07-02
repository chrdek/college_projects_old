Title (Ex07.asm)

.model small
.stack 100h

.data
array1 dw 0,1,2,3,4,5,6,7,8,9
count = ($-array1)/2
var1 dw 0

.code
main proc

	mov ax,@data
	mov ds,ax
	
	mov ax, 0	
	mov di, offset array1
	mov cx,count

looping:
	add ax, word ptr [di]
	add di,2
	loop looping	
	mov var1, ax

	mov ax,4C00h
	int 21h
main endp
end main