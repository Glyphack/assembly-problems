%include "in_out.asm"

section .bss
    a:   resq 1000000
    len: resq 1
    min: resq 1
section .data
    hyphen: db ' ', 0
    func: db 'parameters', 0
section .text
    global _start
_start:
    call readNum
    dec rax
    mov qword [len], rax
    mov rax, 0
    mov qword [min], rax

    ; Read input array
	mov r9, 0
	mov rsi, a
loop:
	cmp r9, qword [len]
	ja sort
    call readNum
    mov qword [rsi], rax 
    add rsi, 8
	inc r9
    jmp loop

sort:
    push qword [len]
    push qword [min]
    call quickSort
    add rsp ,16
    call printArray

Exit:
    mov rax,1
    mov rbx, 0
    int 0x80

printArray:
    push r8
    push rsi
    push rax
    mov r8, 0
    mov rsi, a
printNextElement:
	cmp r8, [len]
    ja finishPrint
	mov rax, qword [rsi]
    call writeNum
	inc r8
    cmp r8, [len]
    ja finishPrint
    push rsi
    mov rsi, hyphen
    call printString
    pop rsi
	add rsi, 8
	jmp printNextElement

finishPrint:
    pop rax
    pop rsi
    pop r8
    ret

quickSort:
    ; rbp+16 = min
    ; rbp+24 = max
    ; sort in place
    
    ;prologue
    push rbp
    mov rbp, rsp

    ; if max < min return
    push r11
    mov r11, qword[rbp+24]
    cmp r11, qword [rbp+16]
    pop r11
    jl epilogue


    ; calculate pivot index

    mov r11, qword[rbp+16] ; low
    mov r12, qword[rbp+24] ; high
    mov r9, a ; array
    
    mov rax, qword [r9+r12*8] ; pivot
    ; call writeNum
    ; call newLine
    mov rcx, r11 ; i = index of smaller element
    dec rcx

    mov rbx, r11 ; j = loop counter
    dec rbx

pivotLoop:
    inc rbx
    cmp rbx, r12 ; if j = high then loop
    je finishPivot
    ; mov rsi,  ; a[j]
    cmp qword[r9+rbx*8], rax ; if a[j] > pivot: continue
    jg pivotLoop

    inc rcx ; else swap pivot element with a[j]
    mov rdi, qword [r9+rcx*8] ; a[i]
    mov rsi, qword [r9+rbx*8] ; a[j]
    mov qword [r9+rcx*8], rsi  ; a[i] = a[j]
    mov qword [r9+rbx*8], rdi; a[j] = a[i]

    jmp pivotLoop

finishPivot:
    inc rcx ; set patition value to i+1
    mov rdi, qword [r9+rcx*8]
    mov rsi, qword [r9+r12*8]
    mov qword [r9+rcx*8], rsi  ; a[i] = a[j]
    mov qword [r9+rbx*8], rdi; a[j] = a[i]

    mov rdx, rcx
    dec rdx ; pivot - 1
    inc rcx ; pivot + 1

    ; save for next call
    push r12
    push rcx
    
    ; quickSort(low, pivot_index - 1)
    push rdx
    push r11
    call quickSort
    add rsp, 16

    pop rcx
    pop r12
    ; ; quickSort(pivot_index + 1, high)
    push r12
    push rcx
    call quickSort
    add rsp, 16

    jmp epilogue

epilogue:
    mov rsp, rbp
    pop rbp
    ret
