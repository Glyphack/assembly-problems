%include "in_out.asm"

section .data
	perfect:  db        "Perfect",13,10, 0
	nope:  db        "Nope",13,10, 0
	space: db	" ", 0

section .bss
	num:	resb 8
	temp: resb 8

section .text
	global	_start

_start:
	call	readNum
	mov		[num], rax
	mov 	ecx, [num]
	dec 	ecx
	mov		esi, 0

nextCheck:
	mov	eax, [num]
	xor	edx, edx
	div	ecx
	cmp edx, 0
	je divisorFoundAdd
Continue:
	dec ecx
	cmp ecx, 1
	jnb nextCheck

checkComplete:
	cmp esi, [num]
	je printYes
	mov rsi, nope
	call printString
	mov	ecx, 1
	jmp end

printYes:
	mov rsi, perfect
	call printString
	mov	ecx, 1
	jmp end

divisorFoundAdd:
	add esi, ecx
	jmp Continue

end:
	mov	eax, [num]
	xor	edx, edx
	div	ecx
	cmp edx, 0
	je divisorFoundPrint

ContinuePrintDiv:
	inc ecx
	cmp ecx, [num]
	jb 	end
	jmp finalEnd

divisorFoundPrint:
	mov rax, 0
	mov eax, ecx
	call writeNum
	mov rsi ,space
	call printString
	jmp ContinuePrintDiv

finalEnd:


Exit:
	mov     rax,    1
	mov     rbx,    0
	int     0x80
