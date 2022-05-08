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
	cmp		ecx, 1
	; edge cases
	je 		printNo
	cmp		ecx, 2
	je		printYes
	dec		ecx

nextCheck:
	mov	eax, [num]
	xor	edx, edx
	div	ecx
	cmp edx, 0
	mov	eax, edx
	cmp eax, 0
	je printNo
	dec ecx
	cmp ecx, 2
	jne nextCheck

	
printYes:
	mov rsi, yes
	call printString
	jmp end

printNo:
	mov rsi, no
	call printString
	jmp end

end:

Exit:
	mov     rax,    1
	mov     rbx,    0
	int     0x80
