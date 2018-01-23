.globl main

.LC0:
.string "ahoj"

main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    call    print
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L3
    jmp .L1
.L3:
    pushl   $0
    popl    %eax
    testl   %eax, %eax
    jnz  .L0
    jmp .L1
.L0:
    pushl   $1
    jmp .L2
.L1:
    pushl   $0
.L2:
    pushl   $0
    popl    %eax
    leave
    ret
print:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   $.LC0
    call    printString
    popl    %ebx
    pushl   $1
    popl    %eax
    leave
    ret
