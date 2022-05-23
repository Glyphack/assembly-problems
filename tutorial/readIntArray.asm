%include "in_out.asm"

section .bss
    a:   resq 1000
    max: resq 1
section .data

section .text
    global _start
_start:
    call readNum
    dec rax
    mov qword [max], rax
    ; Read input array

	mov r9, 0
	mov rsi, a
loop:
	cmp r9, [max]
	ja printArray
    call readNum
    mov qword [rsi], rax 
    add rsi, 8
	inc r9
    jmp loop

printArray:
    mov r9, 0
    mov rsi, a
printNextElement:
	cmp r9, [max]
    ja Exit
	mov rax, qword [rsi]
    call writeNum
	inc r9
	add rsi, 8
	jmp printNextElement


Exit:
    mov eax,1
    mov edi, 0
    int 80h
