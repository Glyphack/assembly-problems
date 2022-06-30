extern scanf
extern printf
extern fflush

%include "in_out.asm"

section .data
	x	dq	0.0

	fmts	db	"%lf", 0
	fmtp	db	"%lf", 0xA, 0

section .bss
	ar:	resb	800
	n:	resb	8

section .text
	global main

main:
push	rbp

	call	readNum
	mov	r9,	rax	;Num of fp
	mov	[n],	r9
	mov	rsi,	ar

	whileRead:	;Read numbers
	cmp	r9,	0
	jz	print
	push	r9
	push	rsi

	mov	rdi,	fmts
	mov	rsi,	x
	call	scanf

	pop	rsi
	pop	r9

	fld	qword[x]
	fstp	qword[rsi]
	add	rsi,	8

	dec	r9
	jmp	whileRead


	afterRead:
	mov	rsi,	ar

	sub	rsi,	8
	xor	r9,	r9
	dec	r9

print:	;Prints two number. the answers.
	mov	rdi,	fmtp
	movq	xmm0,	qword[ar]
	mov	rax,	1
	call	printf


Exit:
pop	rbp
	mov	rax,	1
	mov	rbx,	0
	int	0x80

