%include "in_out.asm"

section .bss
section .data
    n: dq 10
    f: dq 0
section .text
    global _start
_start:
    push qword [n]
    call fac
    add rsp, 8
    mov rax, rcx
    call newLine
    call writeNum

Exit:
    mov eax,1
    mov edi, 0
    int 80h

fac:
    ; rbp+16: n
    
    ;prologue
    push rbp
    mov rbp, rsp

    mov rax, qword[rbp+16]

    call newLine
    call writeNum
    
    cmp rax, 1 ; if n > 1
    ja rec
    mov rcx, 1
    jmp epilogue

rec:    
    mov rdx, rax
    dec rax ; n-1
    push rdx; save n
    push rax ; set arg to n-1
    call fac ; set fac(n-1) in rcx
    pop rax ; n-1
    pop rdx ; restore n
    imul rcx, rdx
    jmp epilogue

epilogue:
    mov rsp, rbp
    pop rbp
    ret
