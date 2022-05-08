%include "in_out.asm"

section .data
	no:  db        " ", 0

section .bss
	num:	resb 4

section .text
	global	_start

_start:
	call	readNum
	mov		ecx, 0
	mov		dil, 0 ; 0 fard 1 zoj

nextCheck:
	xor	edx, edx
	mov	esi, 10
	div	esi
	mov	[num], edx
	and	edx, 01H     ; ANDing with 0000 0001
	jz  addEven
	add ebx, [num]

ContinueLoop:
	cmp eax, 0
	ja	nextCheck
	jmp printResult

addEven:
	add ecx, [num]
	jmp ContinueLoop

printResult:
	mov rax, 0
	mov	eax, ebx
	call writeNum
	mov	rsi, no
	call printString
	mov rax, 0
	mov eax, ecx
	call writeNum

Exit:
	mov     rax,    1
	mov     rbx,    0
	int     0x80
