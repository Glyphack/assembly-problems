
%include "in_out.asm"

section .data
	result: db 25h
	binary: db ?

section .bss
	num:	resb 8
	num2:	resb 8

section .text
	global	_start

_start:
	call	readNum
	mov		[num], rax
	call	writeNum


Exit:
	mov     rax,    1
	mov     rbx,    0
	int     0x80
