%include "in_out.asm"

section .bss
section .data

section .text
    global _start
_start:
    mov ecx, 0
    call readNum
    mov rbx, 2
convertToBinary:
    mov rdx, 0
    div rbx
    cmp rdx, 1
    je addOne 
continueAfterInc:
    cmp rax, 0
    jne convertToBinary
    jmp printAndExit
addOne:
    inc ecx
    jmp continueAfterInc
printAndExit:
    mov rax, 0
    mov eax, ecx
    call writeNum
    mov eax,1
    mov edi, 0
    int 80h
