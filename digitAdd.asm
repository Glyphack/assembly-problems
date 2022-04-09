%include "in_out.asm"

section .data
	no:  db        "No", 0
	yes:  db        "Yes", 0

section .bss
	num:	resb 8

section .text
	global	_start

_start:
	call	readNum
	mov		[num], rax
	mov 	ecx, [num]
	mov		ebx, 0

nextCheck:
	xor	edx, edx
	mov	esi, 10
	div	esi
	add ebx, edx
	cmp eax, 0
	ja	nextCheck

	
printResult:
	mov rax, 0
	mov	eax, ebx
	call writeNum

Exit:
	mov     rax,    1
	mov     rbx,    0
	int     0x80
