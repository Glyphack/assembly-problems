%include "in_out.asm"

%macro mid 3
    push rdx
    push rbx

    mov rdx, 0
    mov rax, qword [%1]
    add rax, qword [%2]
    mov rbx, 2
    div rbx

    pop rbx
    pop rdx
%endmacro


section .bss
    a:   resq 1000000
    len: resq 1
    min: resq 1
    max: resq 1
    query: resq 1
    queryCount: resq 1
    result: resq 1
section .data
    NaN: db 'NaN', 0
section .text
    global _start
_start:
    call readNum
    mov qword [len], rax
    dec rax
    mov qword [max], rax
    mov qword [min], 0

    ; Read input array
	mov r9, 0
	mov rsi, a
loop:
	cmp r9, qword [len]
	je getQueries
    call readNum
    mov qword [rsi], rax 
    add rsi, 8
	inc r9
    jmp loop

; get search queries
getQueries:
    mov r8, 0 ; query loop counter
    call readNum
    mov qword [queryCount], rax ; number of queries
getQuery:
    cmp r8, qword [queryCount]
    je Exit
    call readNum
    mov [query], rax
    mov rcx, -1
    push qword [query]
    push qword [max]
    push qword [min]
    call binarySearch
    add rsp ,24
    mov qword [result], rcx
    cmp qword [result], -1
    je writeNan
    jne writeResult

Exit:
    mov rax,1
    mov rbx, 0
    int 0x80

writeNan:
    mov rsi, NaN
    call newLine
    call printString
    inc r8
    jmp getQuery

writeResult:
    mov rax, qword [result]
    call newLine
    call writeNum
    inc r8
    jmp getQuery

binarySearch:
    ; rbp+16 = min
    ; rbp+24 = max
    ; rbp+32 = query
    ; rax, rbx,rdx are used and rcx is result
    
    ;prologue
    push rbp
    mov rbp, rsp

    ; push rax
    ; mov rax, qword [rbp+16]
    ; call writeNum
    ; call newLine
    ; mov rax, qword[rbp+24]
    ; call writeNum
    ; call newLine
    ; call newLine
    ; pop rax

    ; if max < min return
    push r11
    mov r11, qword[rbp+24]
    cmp r11, qword [rbp+16]
    pop r11
    jl epilogue


    ; calc mid in rax
    mid rbp+16, rbp+24, rax

    ; call writeNum
    ; call newLine

    ; check if mid is query
    mov r9, a
    mov rbx, qword [r9+rax*8] ; array middle
    cmp rbx, qword [rbp+32]
    ja smallerMid
    jb biggerMid
    
    ; while (a[middle - 1] == key):
getElementWithLowerIndex:
    mov rcx, rax
    dec rax
    cmp rbx, qword [r9+rax*8]
    je getElementWithLowerIndex

    jmp epilogue

smallerMid:    
    mov rdx, rax; save current mid
    dec rdx
    push qword [rbp+32]
    push rdx ; new max = mid-1
    push qword [rbp+16] ; new min = old min
    call binarySearch ; set fac(n-1) in rcx
    add rsp, 24
    jmp epilogue

biggerMid:   
    mov rdx, rax; save current mid
    inc rdx
    push qword [rbp+32]
    push qword [rbp+24] ; new max = old max
    push rdx ; new min = mid+1
    call binarySearch ; set fac(n-1) in rcx
    add rsp, 24
    jmp epilogue

epilogue:
    mov rsp, rbp
    pop rbp
    ret
