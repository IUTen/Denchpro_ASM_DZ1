use16
org 100h

call main

mov ax, 0

int 16h
int 20h

main:
	mov ax, 0xb800
	mov es, ax
	
	mov di, 0
	
	call loopp	

	ret

loopp:
	mov di, 0x640
	mov cx, 80
	main_loop:	
		cmp di, 0x6D0
		jge clear

		call print
		call Delay

		print2:
			push ax

			mov ax, 03
			int 10h
			
			pop ax

			add di, 4	

		loop main_loop
	
	ret


Delay:
	pusha
	mov ah, 0x0
	int 1ah
.Wait:
	mov bx, dx
	mov ah,0
	int 1ah
	cmp bx, dx
	je .Wait
	popa
	ret
	
clear:
	mov di, 0x640
	jmp main_loop
	ret

print:	
	pusha
	mov si, msg

	mov cx, 5 
	lp:
		movsw
		add di, 2
		loop lp

	popa
	ret

msg dw 0xC044, 0xC045, 0xC04E, 0xC049, 0xC053
