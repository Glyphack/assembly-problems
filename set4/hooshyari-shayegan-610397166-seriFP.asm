extern scanf
extern printf
extern fflush
%include "in_out.asm"

section .data
	fmts	db	"%lf", 0
	fmtp	db	"%lf", NL, 0
	fmt db "%lf", 0
    x	dq	0.0 ; holds f numbers
	powerRes dq 0.0	
	facRes dq 0.0
	one dq 1.0
	sum dt 0.0

section .bss
	n 	 resb 8
    tmpfac resb 500

section .text
	global main

main:
	push	rbp

	call	readNum
	mov	[n],	rax	;Num of fp
	
    mov	rdi,	fmts
    mov	rsi,	x    
    call	scanf
    
	mov r15, 0

next:
	cmp r15, [n]
	ja Exit
	
    fld qword [one]
    mov rcx, r15
mult:
    cmp rcx, 0
    je finishMult
    fmul qword [x]
    dec rcx
    jmp mult
finishMult:
    fstp qword [powerRes]
	
	push r15
    call fac
    add rsp, 8
	mov qword[facRes], rcx
	fild qword[facRes]
	fstp qword[facRes]

	fld qword[one]
	fdiv qword[facRes]
	fmul qword[powerRes]
	fadd qword[sum]
	fstp qword[sum]

	movsd xmm0, qword[facRes]
	mov rdi, fmtp
	mov rax, 1
	; call printf
	
	inc r15
	jmp next

Exit:
	movsd xmm0, qword[sum]
	mov rdi, fmt
	mov rax, 1
	call printf
	
	xor	rdi,	rdi
	call	fflush
	pop	rbp
	mov	rax,	sys_exit
	xor rdi, rdi
	syscall

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

fac:
    ; rbp+16: n
    
    ;prologue
    push rbp
    mov rbp, rsp

    mov rax, qword[rbp+16]

    cmp rax, 1 ; if n > 1
    ja rec
    mov 
    jmp epilogue

rec:    
    mov rdx, rax
    dec rax ; n-1
    push rdx; save n
    push rax ; set arg to n-1
    call fac ; set fac(n-1) in rcx
    pop rax ; n-1
    pop rdx ; restore n
    imul rcx, rdx
    jmp epilogue

epilogue:
    mov rsp, rbp
    pop rbp
    ret
