%include "in_out.asm"

section .bss
section .data
    array2 times 64 dq 0
    arraySize db 64

section .text
    global _start
_start:
    lea edi, [array2]
    mov ecx, 0
    call readNum
    mov rbx, 2
convertToBinaryAndSaveInArray:
    mov rdx, 0
    div rbx
    mov [edi+ ecx*8], rdx
    inc ecx
    cmp rax, 0
    jne convertToBinaryAndSaveInArray

printArray:
    mov ecx, 0
printNextElement:
    mov rax, 0
    mov rax, [edi+ecx*8]
    call writeNum
    inc ecx
    cmp ecx, [arraySize]
    jl printNextElement
    jmp _exit


_exit:
    mov eax,1
    mov edi, 0
    int 80h
