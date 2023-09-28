section .data 
    my_string db 'hello world'
    new_lines db '\n\n\n'
    clr_screen db 27, '[2J', 27, '[;H', 0  ;
    my_array db 10,20,30,40,50
    
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
    push rbp
    xor rbp, rcx
    jz pnew
    
    pop rbp
    inc rbp
    jmp holder

pnew:
    lea rsi, [new_lines]
    mov rdx, 3  
    mov rbp, 0
    
    syscall

    mov rsi, my_array
    mov rdx, 5

.print_array:
    mov al, [rsi]
    syscall
    

exit:
    mov rax, 60
    mov rdi, 0
    syscall    


