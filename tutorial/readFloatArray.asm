extern scanf
extern printf
extern fflush
%include "in_out.asm"

section .data
	fmts	db	"%lf", 0
	fmtp	db	"%lf", NL, 0xA
    x	dq	0.0 ; holds f numbers

section .bss
	arr resq 1000
	n 	 resb 8

section .text
	global main

main:

	push	rbp

	call	readNum
	mov	[n],	rax	;Num of fp
	
    mov	rbx,	arr
    mov rcx, [n]
    call inputArray

    mov rbx, arr
    mov rcx, [n]
    call writeArray
    jmp Exit

Exit:
	xor	rdi,	rdi
	call	fflush
	pop	rbp
	mov	rax,	1
	mov	rbx,	0
	int	0x80

writeArray: ; pointer to array in rbx and count in rcx
    push rbp
    mov rbp, rsp
writeNext:
    cmp	rcx,	0
    je	epilogue

	mov	rdi,	fmtp
	movq	xmm0,	qword[rbx]
	mov	rax,	1
	
    push rbx
    push rcx
    call	printf
	pop rcx
    pop rbx
    
    dec rcx
    add rbx, 8
    
    jmp writeNext


inputArray:	; pointer to array in rbx and count in rcx
    push rbp
    mov rbp, rsp
readNext:
    cmp	rcx,	0
    je	epilogue
    mov	rdi,	fmts
    mov	rsi,	x
    
    push rbx
    push rcx
    call	scanf
    pop rcx
    pop rbx
    
    fld	qword[x]
    fstp	qword[rbx]
    add	rbx,	8

    dec	rcx
    jmp readNext

epilogue:
    mov rsp, rbp
    pop rbp
    ret
