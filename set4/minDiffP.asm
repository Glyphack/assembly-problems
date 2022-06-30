extern scanf
extern printf
extern fflush
%include "in_out.asm"

section .data
	fmts	db	"%lf", 0
	fmtp	db	"%lf %lf", 0
    x	dq	0.0 ; holds f numbers
    min dq  1000000.0

section .bss
	arr resq 1000
    ans resq 3
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

    fld qword[min]
    mov r8, -1
    
firstLoop:
    inc r8
    cmp r8, [n]
    je finish
    mov r9, r8
    inc r9

secondLoop:
    cmp r9, [n]
    je firstLoop

    fld qword[arr+r8*8] ; st1 = min st0 = arr(i)
    fsub qword[arr+r9*8]
    fabs ; st0 = curr diff
    fcomi st0, st1
    jb incJ

    fstp qword[x] ; now st0 is new min
    
    inc r9
    jmp secondLoop
incJ:
    ; save two min diff elements in first and second index of ans array
    mov rsi, 1
    fld qword[arr+r8*8]
    fstp qword[ans]
    fld qword[arr+r9*8]
    fstp qword[ans+rsi*8]
    fxch
    fstp qword[x]

    inc r9
    jmp secondLoop

finish:
    mov r15, 1
    mov	rdi,	fmtp
	movsd	xmm0,	qword[ans]
    movsd xmm1, qword[ans+r15*8]
	mov	rax,	1
    call	printf

Exit:
	xor	rdi,	rdi
	call	fflush

	mov	rax,	1
	mov	rbx,	0
	int	0x80

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
