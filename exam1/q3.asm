%include "in_out.asm"

section .data
	space: db	" ", 0

section .bss
	num:	resb 8
	temp: resb 8

section .text
	global	_start

_start:
	call	readNum
	mov		[num], rax
	mov 	ecx, 1
	mov		esi, 0

nextCheck:
	mov	eax, [num]
	xor	edx, edx
	div	ecx
	cmp edx, 0
	je divisorFoundAdd
Continue:
	inc ecx
	cmp ecx, [num]
	jbe nextCheck
    jmp end

; ecx is divisor
divisorFoundAdd:
    cmp esi, ecx
    je end
    mov [temp], rax
    mov rax, 0
    mov eax, ecx
    call writeNum
    mov rsi, space
    call printString
    mov rsi, 0
    mov eax, [num]
    mov edx, 0
    div ecx
    call writeNum
    call newLine
    mov esi, eax
	jmp Continue

end:


Exit:
	mov     rax,    1
	mov     rbx,    0
	int     0x80
