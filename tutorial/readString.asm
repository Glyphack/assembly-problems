%include "in_out.asm"

section .bss
    a:   resd 1000
section .data

section .text
    global _start
_start:
    call readNum
	mov r8, rax
	mov r9, 0
	mov rsi, a
loop:
	cmp r8, r9
	je printArray
    call readNum
    mov [rsi], al ; Move a number in range 0,255 to a
    inc rsi
	inc r9
    jmp loop

printArray:
    mov r9, 0
    mov rsi, a
printNextElement:
	cmp r8, r9
	je printArrayReverse
	mov al, [rsi]
	call writeNum
	inc r9
	inc rsi
	jmp printNextElement
	
printArrayReverse:
	call newLine
	mov r9, r8
	dec r9
	mov rsi, a
	add rsi, r9
printNextElementReverse:
	cmp r9, 0
	jb Exit
	mov al, [rsi]
	call writeNum
	dec rsi
	dec r9
	jmp printNextElementReverse
	

Exit:
    mov eax,1
    mov edi, 0
    int 80h
