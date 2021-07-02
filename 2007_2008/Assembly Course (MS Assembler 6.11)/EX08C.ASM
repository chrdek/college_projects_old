Title Exercise8c(ex08c.asm)
.model small
.stack 100h

.data

array1 db 0,1,2,3,4,5,6,7,8,9
count1 = ($ - array1) ;Count num of elements in array 1
tmp dw 0              ;Used for temporary inner loop index storage

array2 db 2,4,6,8
count2 = ($ - array2) ;Count num of elements in array 2     
array3 db 10 dup(?)

.code
main proc

mov ax,@data
mov ds,ax

mov ax,0
mov bx,0
mov si,0
mov cx,count1

	OuterL: 
	  mov al,array1[bx]
	  mov tmp,cx
	  mov si,0
	  mov cx,count2

		InnerL:
		  add al,array2[si]
		  inc si
		loop InnerL

	  mov cx,tmp
	  mov array3[bx],al
	  inc bx
	loop OuterL

mov ax,4C00h
int 21h

main endp
end main