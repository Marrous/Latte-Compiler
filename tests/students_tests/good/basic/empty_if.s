.globl main


main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   $0
    popl    %eax
    testl   %eax, %eax
    jnz  .L0
    jmp .L1
.L0:
.L1:
    pushl   $1
    call    printInt
    popl    %ebx
    pushl   $0
    popl    %eax
    leave
    ret
