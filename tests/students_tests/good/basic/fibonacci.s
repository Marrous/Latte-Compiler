.globl main

.LC0:
.string "Expected a non-negative integer, but got:"

fibonacci:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp
    pushl   8(%ebp)
    pushl   $1
    popl    %eax
    cmpl    %eax, 0(%esp)
    jg  .L2
    pushl   $1
    jmp .L3
.L2:
    pushl   $0
.L3:
    popl    %eax
    testl   %eax, %eax
    jnz  .L0
    jmp .L1
.L0:
    pushl   8(%ebp)
    popl    %eax
    leave
    ret
.L1:
    pushl   $0
    popl    -4(%ebp)
    pushl   $1
    popl    -8(%ebp)
    pushl   $0
    popl    -12(%ebp)
    pushl   $2
    popl    -16(%ebp)
.L4:
    pushl   -16(%ebp)
    pushl   8(%ebp)
    popl    %eax
    cmpl    %eax, 0(%esp)
    jg  .L7
    pushl   $1
    jmp .L8
.L7:
    pushl   $0
.L8:
    popl    %eax
    testl   %eax, %eax
    jnz  .L5
    jmp .L6
.L5:
    leal    -12(%ebp), %eax
    pushl   %eax
    pushl   -8(%ebp)
    pushl   -4(%ebp)
    popl    %eax
    popl    %ebx
    addl    %ebx, %eax
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -4(%ebp), %eax
    pushl   %eax
    pushl   -8(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -8(%ebp), %eax
    pushl   %eax
    pushl   -12(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -16(%ebp), %eax
    pushl   %eax
    popl    %eax
    incl    (%eax)
    jmp .L4
.L6:
    pushl   -8(%ebp)
    popl    %eax
    leave
    ret
main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $4, %esp
    call    readInt
    pushl   %eax
    popl    -4(%ebp)
    pushl   -4(%ebp)
    pushl   $0
    popl    %eax
    cmpl    %eax, 0(%esp)
    jl  .L12
    pushl   $1
    jmp .L13
.L12:
    pushl   $0
.L13:
    popl    %eax
    testl   %eax, %eax
    jnz  .L9
    jmp .L10
.L9:
    pushl   -4(%ebp)
    call    fibonacci
    popl    %ebx
    pushl   %eax
    call    printInt
    popl    %ebx
    pushl   $0
    popl    %eax
    leave
    ret
    jmp .L11
.L10:
    pushl   $.LC0
    call    printString
    popl    %ebx
    pushl   -4(%ebp)
    call    printInt
    popl    %ebx
    pushl   $1
    popl    %eax
    leave
    ret
.L11:
    leave
    ret
