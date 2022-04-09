%include "in_out.asm"

section .data

section .bss
	num:	resb 8
	num2:	resb 8

section .text
	global	_start

_start:
	call	readNum
	mov		[num], rax
	call	readNum
	mov		[num2], rax
	add		rax, [num]
	call	writeNum


Exit:
	mov     rax,    1
	mov     rbx,    0
	int     0x80
