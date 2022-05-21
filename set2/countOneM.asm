%include "in_out.asm"
        
section .data
    two db 2

section .bss
    i: resq 1
    j: resq 1
    list resb 100

section .text
    global _start
 
_start:
    call readNum
    mov [i], rax
    call readNum
    mov [j], rax

    mov rcx, qword [j]
    inc rcx
    mov  rax,  sys_read
    mov  rsi,  list        ;Start of the memory
    mov  rdi,  stdin
    mov  rdx,  rcx          ;Length
    syscall
    
    xor rax, rax
    xor rdx, rdx
    xor rdx, rdx
    xor rcx, rcx

    mov rsi, list
loop:
    mov al, byte [rsi+rdx]
    cmp rdx, qword [j] 
    ja realPrint
    cmp rdx, qword [i]
    jb skipElement
converToBin:
    cmp al, 0
    je nextChar
    mov ah, 0
    div byte [two]
    add cl, ah
    mov ah, 0
    jmp converToBin
nextChar:
    inc rdx
    jmp loop

skipElement:
    inc rdx
    jmp loop

realPrint:
    xor rax, rax
    mov al, cl
    call writeNum
    call newLine

Exit:
    mov rax, 1
    mov rbx, 0
    int 0x80
