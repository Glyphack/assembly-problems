extern scanf
extern printf
extern fflush

section .data
	x	dq	0.0	;The X
	fmts	db	"%lf", 0
	fmtp	db	"%lf", 0xA

section .bss

section .text
	global main

main:
	push	rbp
	
	mov	rdi,	fmts
	mov	rsi,	x
	call	scanf

	mov	rdi,	fmtp
	movq	xmm0,	qword[x]
	mov	rax,	1
	call	printf
	
	xor	rdi,	rdi
	call	fflush


Exit:
	pop	rbp
	mov	rax,	1
	mov	rbx,	0
	int	0x80

