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
	je      findLfc
	jb      swapVals

gcdDivide:
	xor     dx, dx  
    div		bx
    cmp     dx, 0
    je		findLfc
    mov     ax, dx
    jmp     gcdDOne

swapVals:
	xchg	ax, bx 
	jmp		gcdDivide  

findLfc:      
	mov     [gcd], bx
    mov		rax, rbx
	mov		rax, [first]
	mov		rbx, [second]
	mul		bx
	; ax = first * second
	mov		bx, [gcd]
	div		bx
	call 	writeNum

Exit:
	mov     rax,    1
	mov     rbx,    0
	int     0x80
