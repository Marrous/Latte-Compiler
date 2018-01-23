.globl main


main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
.L0:
    pushl   $1
    popl    %eax
    testl   %eax, %eax
    jnz  .L1
    jmp .L2
.L1:
    pushl   $0
    popl    %eax
    leave
    ret
    jmp .L0
.L2:
    leave
    ret
