loop
```asm
l1:
	xor rdx, rdx
	mov rax, [num]
	div rsi
	mov 
	call writeNum
	cmp rax, 0
	jg l1
```

new program
```
section .text

global _start

_start:

    mov     eax, [x]
    sub     eax, '0'
    mov     ebx, [y]
    sub     ebx, '0'
    add     eax, ebx
    add     eax, '0'

    mov     [sum], eax

    mov     ecx, msg
    mov     edx, len
    mov     ebx, 1
    mov     eax, 4
    int     0x80

    mov     ecx, sum
    mov     edx, 1
    mov     ebx, 1
    mov     eax, 4
    int     0x80

    mov     eax, 1
    int     0x80

section .data
    x db '5'
    y db '3'
    msg db  "sum of x and y is "
    len equ $ - msg

segment .bss

    sum resb 1
```
