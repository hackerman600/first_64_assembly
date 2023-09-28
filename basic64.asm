section .data 
    my_string db 'hello world'
    new_lines db 0x0A
    clr_screen db 27, '[2J', 27, '[;H', 0  ;
    my_array db '10','20','30','40','50'

    ;array summation data
    array1 dw 5,10,15,20,25
    array2 dw 10,20,30,40,50
    array3 dw 0,0,0,0,0
    
section .text
    global _start


;GP REGISTERS
;RAX: Accumulator register
;RBX: Base register
;RCX: Count register
;RDX: Data register
;RDI: Destination index register
;RSI: Source index register
;RBP: Base pointer register
;RSP: Stack pointer register


_start:

    mov rcx, 1000 ;define the number of itters to hold target for.
    mov rbp, 0

    mov rax, 1
    mov rdi, 1
    mov rdx, 11
    lea rsi, [my_string]   
    syscall

;print the array on the screen right after the new lines after some moments.    

holder:
    cmp rbp, rcx
    je new_line_creation
    
    inc rbp
    jmp holder


pnew:
    mov rax, 1
    mov rdi, 1
    lea rsi, [new_lines]
    mov rdx, 1  
    
    syscall
    ret

new_line_creation:
    call pnew   
    call pnew   

.setrbp:
    mov rbp, 0

.print_array:

    ;print value to screen

    cmp rbp,8
    je initialise_array_multiplication_env

    mov rax, 1
    mov rdi, 1      
    mov rdx, 2
    lea rsi, [my_array]
    add rsi, rbp 
    syscall

    ;print a new line
    push rax
    push rdi
    push rsi
    push rdx 

    call pnew

    pop rax
    pop rdi
    pop rsi
    pop rdx 

    add rbp,2

    jmp .print_array


initialise_array_multiplication_env:
    mov rcx, array1
    mov rbp, array2
    mov rbx, 5


;single instruction multiple data
array_multiplication:
    mov sp, 0
    mov al, [rcx]
    mov dl, [rbp]

    mul dl

    inc rcx
    inc rbp
    
    ;loop array_multiplication
    ;jmp exit 


exit:
    mov rax, 60
    mov rdi, 0
    syscall    


