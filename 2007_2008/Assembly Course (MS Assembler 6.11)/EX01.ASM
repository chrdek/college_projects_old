Title (EX01.asm)
.model small
.stack 100h
.data
byte1 db 1
byte2 db 0
word1 dw 1234h
word2 dw 0
string db "This is a string",0

.code
main proc
	mov ax,@data
	mov ds,ax
	mov ax,offset byte1
	mov ax,offset byte2
	mov ax,offset word1
	mov ax,offset word2
	mov ax,offset string
	
	mov ax,0
	inc ax
	dec ax
	inc ax
	inc ax
	add ax,2
	add ax,4
	add ax,7
	inc ax
	sub ax,16
	add ax,4
	
	mov ax,0
	mov al,byte1
	mov byte2,al
	mov cx,word1
	mov word2,cx
	
	mov ax,4C00h
	int 21h
main endp
end main