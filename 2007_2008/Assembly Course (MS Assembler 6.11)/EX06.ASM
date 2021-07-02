Title (Ex06.asm)

.model small
.stack 100h


.data
stringA db "Assembly Language is a useful and interesting course.I will study and get an A in CORS 211.!!!!"
count = ($-stringA)
stringB db count dup (?)


.code

main proc

	mov ax,@data
	mov ds,ax
	
	mov si, offset stringA
	mov bx, offset stringB
	
	mov cx,count	
	
LabelA:
	mov al, byte ptr [si]
	mov byte ptr [bx], al
	inc si
	inc bx
	loop LabelA

	mov ax,4C00h
	int 21h

main endp
end main
