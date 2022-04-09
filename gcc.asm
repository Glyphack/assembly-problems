%include "in_out.asm"


section .bss	
	gcd resb	4
	first resb	8
	second resb	8

section .text
	global	_start

_start:
	call	readNum ; first num rax second num rbx
	mov		rbx, rax
	call	readNum
	xchg	rax, rbx
	mov		[first], rax
	mov		[second], rbx


gcdDOne:
	cmp     rax, rbx
	je      printGcd
	jb      swapVals

gcdDivide:
	xor     dx, dx  
    div		rbx
    cmp     dx, 0
    je		printGcd
    mov     ax, dx
    jmp     gcdDOne

swapVals:
	xchg	rax, rbx 
	jmp		gcdDivide  

printGcd:      
	mov     rax, rbx
	call	writeNum

Exit:
	mov     rax,    1
	mov     rbx,    0
	int     0x80
