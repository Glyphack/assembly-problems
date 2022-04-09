section .data

section .bss
	num:	resb 4
	num2:	resb 4

section .text
	global	_start

_start:
	call	readNum
	mov	[num], rax
	call	readNum
	mov	[num2], rax
	add	rax, [num2]
	call	writeNum


Exit:
	mov     rax,    1
	mov     rbx,    0
	int     0x80
