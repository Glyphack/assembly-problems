%include "in_out.asm"

section .bss
section .data
    n: dq 10
    f: dq 0
    temp: dq 100
    a: db 'a'
section .text
    global _start
_start:
    push qword [n]
    call fac
    add rsp, 8
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

    call newLine
    mov rsi, a
    call printString

    push rax
    mov rax, qword[rbp+16]
    call writeNum
    pop rax
    
    cmp qword[rbp+16], 1 ; if n > 1
    jg rec

    mov rax, 1

    ; epilogue

    mov rsp, rbp
    pop rbp
    ret

rec:
    push r8
    
    mov r8, qword[rbp+16]
    dec r8
    
    ; push rax
    ; mov rax, r8
    ; call newLine
    ; call writeNum
    ; pop rax
    
    push qword[r8]
    call fac
    ; add rsp, 8

    imul rax, r8    
    

    pop r8
    ret
