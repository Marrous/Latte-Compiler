.globl main


main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $24, %esp
    pushl   $4
    pushl   $10
    call    calloc
    popl    %ebx
    popl    %ecx
    pushl   %ebx
    pushl   %eax
    popl    -8(%ebp)
    popl    -4(%ebp)
    pushl   $0
    popl    -12(%ebp)
.L0:
    pushl   -12(%ebp)
    leal    -8(%ebp), %eax
    pushl   %eax
    popl    %eax
    pushl   4(%eax)
    popl    %eax
    cmpl    %eax, 0(%esp)
    jge .L3
    pushl   $1
    jmp .L4
.L3:
    pushl   $0
.L4:
    popl    %eax
    testl   %eax, %eax
    jnz  .L1
    jmp .L2
.L1:
    leal    -8(%ebp), %eax
    pushl   %eax
    pushl   -12(%ebp)
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    pushl   -12(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -12(%ebp), %eax
    pushl   %eax
    popl    %eax
    incl    (%eax)
    jmp .L0
.L2:
    pushl   $0
    popl    -16(%ebp)
.L5:
    pushl   -16(%ebp)
    leal    -8(%ebp), %eax
    pushl   %eax
    popl    %eax
    pushl   4(%eax)
    popl    %eax
    cmpl    %eax, 0(%esp)
    jge .L8
    pushl   $1
    jmp .L9
.L8:
    pushl   $0
.L9:
    popl    %eax
    testl   %eax, %eax
    jnz  .L6
    jmp .L7
.L6:
    leal    -8(%ebp), %eax
    pushl   %eax
    pushl   -16(%ebp)
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    popl    %eax
    pushl   (%eax)
    popl    -20(%ebp)
    pushl   -20(%ebp)
    call    printInt
    popl    %ebx
    leal    -16(%ebp), %eax
    pushl   %eax
    popl    %eax
    incl    (%eax)
    jmp .L5
.L7:
    pushl   $45
    popl    -16(%ebp)
    pushl   -16(%ebp)
    call    printInt
    popl    %ebx
    pushl   $0
    popl    %eax
    leave
    ret
