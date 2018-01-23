.globl main


main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
.L0:
    pushl   $0
    popl    %eax
    testl   %eax, %eax
    jnz  .L1
    jmp .L2
.L1:
    jmp .L0
.L2:
    pushl   $1
    call    printInt
    popl    %ebx
    pushl   $0
    popl    %eax
    leave
    ret
