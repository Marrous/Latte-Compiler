.globl main


swap:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $4, %esp
    leal    16(%ebp), %eax
    pushl   %eax
    pushl   12(%ebp)
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    popl    %eax
    pushl   (%eax)
    popl    -4(%ebp)
    leal    16(%ebp), %eax
    pushl   %eax
    pushl   12(%ebp)
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    leal    16(%ebp), %eax
    pushl   %eax
    pushl   8(%ebp)
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    popl    %eax
    pushl   (%eax)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    16(%ebp), %eax
    pushl   %eax
    pushl   8(%ebp)
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    pushl   -4(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leave
    ret
heapDown:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $12, %esp
.L0:
    pushl   12(%ebp)
    pushl   $2
    popl    %eax
    popl    %ebx
    imul    %ebx, %eax
    pushl   %eax
    pushl   8(%ebp)
    pushl   $1
    popl    %eax
    popl    %ebx
    subl    %eax, %ebx
    pushl   %ebx
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
    pushl   12(%ebp)
    pushl   $2
    popl    %eax
    popl    %ebx
    imul    %ebx, %eax
    pushl   %eax
    pushl   $1
    popl    %eax
    popl    %ebx
    addl    %ebx, %eax
    pushl   %eax
    popl    -4(%ebp)
    pushl   -4(%ebp)
    pushl   $1
    popl    %eax
    popl    %ebx
    addl    %ebx, %eax
    pushl   %eax
    popl    -8(%ebp)
    pushl   -4(%ebp)
    popl    -12(%ebp)
    pushl   -8(%ebp)
    pushl   8(%ebp)
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
    jnz  .L7
    jmp .L6
.L7:
    leal    16(%ebp), %eax
    pushl   %eax
    pushl   -8(%ebp)
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    popl    %eax
    pushl   (%eax)
    leal    16(%ebp), %eax
    pushl   %eax
    pushl   -12(%ebp)
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    popl    %eax
    pushl   (%eax)
    popl    %eax
    cmpl    %eax, 0(%esp)
    jle .L10
    pushl   $1
    jmp .L11
.L10:
    pushl   $0
.L11:
    popl    %eax
    testl   %eax, %eax
    jnz  .L5
    jmp .L6
.L5:
    leal    -12(%ebp), %eax
    pushl   %eax
    pushl   -8(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
.L6:
    leal    16(%ebp), %eax
    pushl   %eax
    pushl   -12(%ebp)
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    popl    %eax
    pushl   (%eax)
    leal    16(%ebp), %eax
    pushl   %eax
    pushl   12(%ebp)
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    popl    %eax
    pushl   (%eax)
    popl    %eax
    cmpl    %eax, 0(%esp)
    jle .L15
    pushl   $1
    jmp .L16
.L15:
    pushl   $0
.L16:
    popl    %eax
    testl   %eax, %eax
    jnz  .L12
    jmp .L13
.L12:
    pushl   20(%ebp)
    pushl   16(%ebp)
    pushl   -12(%ebp)
    pushl   12(%ebp)
    call    swap
    popl    %ebx
    popl    %ebx
    popl    %ebx
    popl    %ebx
    leal    12(%ebp), %eax
    pushl   %eax
    pushl   -12(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    jmp .L14
.L13:
    leave
    ret
.L14:
    jmp .L0
.L2:
    leave
    ret
extractMax:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $4, %esp
    leal    12(%ebp), %eax
    pushl   %eax
    pushl   $0
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    popl    %eax
    pushl   (%eax)
    popl    -4(%ebp)
    leal    12(%ebp), %eax
    pushl   %eax
    pushl   $0
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    leal    12(%ebp), %eax
    pushl   %eax
    pushl   8(%ebp)
    pushl   $1
    popl    %eax
    popl    %ebx
    subl    %eax, %ebx
    pushl   %ebx
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    popl    %eax
    pushl   (%eax)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    pushl   16(%ebp)
    pushl   12(%ebp)
    pushl   $0
    pushl   8(%ebp)
    pushl   $1
    popl    %eax
    popl    %ebx
    subl    %eax, %ebx
    pushl   %ebx
    call    heapDown
    popl    %ebx
    popl    %ebx
    popl    %ebx
    popl    %ebx
    pushl   -4(%ebp)
    popl    %eax
    leave
    ret
heapSort:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $4, %esp
    leal    8(%ebp), %eax
    pushl   %eax
    popl    %eax
    pushl   4(%eax)
    pushl   $2
    popl    %ebx
    popl    %eax
    movl    %eax, %edx
    sar    $31, %edx
    idiv    %ebx
    pushl   %eax
    popl    -4(%ebp)
.L17:
    pushl   -4(%ebp)
    pushl   $0
    popl    %eax
    cmpl    %eax, 0(%esp)
    jl  .L20
    pushl   $1
    jmp .L21
.L20:
    pushl   $0
.L21:
    popl    %eax
    testl   %eax, %eax
    jnz  .L18
    jmp .L19
.L18:
    pushl   12(%ebp)
    pushl   8(%ebp)
    pushl   -4(%ebp)
    leal    8(%ebp), %eax
    pushl   %eax
    popl    %eax
    pushl   4(%eax)
    call    heapDown
    popl    %ebx
    popl    %ebx
    popl    %ebx
    popl    %ebx
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    decl    (%eax)
    jmp .L17
.L19:
    leal    -4(%ebp), %eax
    pushl   %eax
    leal    8(%ebp), %eax
    pushl   %eax
    popl    %eax
    pushl   4(%eax)
    pushl   $1
    popl    %eax
    popl    %ebx
    subl    %eax, %ebx
    pushl   %ebx
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
.L22:
    pushl   -4(%ebp)
    pushl   $0
    popl    %eax
    cmpl    %eax, 0(%esp)
    jl  .L25
    pushl   $1
    jmp .L26
.L25:
    pushl   $0
.L26:
    popl    %eax
    testl   %eax, %eax
    jnz  .L23
    jmp .L24
.L23:
    leal    8(%ebp), %eax
    pushl   %eax
    pushl   -4(%ebp)
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    pushl   12(%ebp)
    pushl   8(%ebp)
    pushl   -4(%ebp)
    pushl   $1
    popl    %eax
    popl    %ebx
    addl    %ebx, %eax
    pushl   %eax
    call    extractMax
    popl    %ebx
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    decl    (%eax)
    jmp .L22
.L24:
    leave
    ret
main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $24, %esp
    call    readInt
    pushl   %eax
    popl    -4(%ebp)
    pushl   $4
    pushl   -4(%ebp)
    call    calloc
    popl    %ebx
    popl    %ecx
    pushl   %ebx
    pushl   %eax
    popl    -12(%ebp)
    popl    -8(%ebp)
    pushl   $0
    popl    -16(%ebp)
.L27:
    pushl   -16(%ebp)
    pushl   -4(%ebp)
    popl    %eax
    cmpl    %eax, 0(%esp)
    jge .L30
    pushl   $1
    jmp .L31
.L30:
    pushl   $0
.L31:
    popl    %eax
    testl   %eax, %eax
    jnz  .L28
    jmp .L29
.L28:
    leal    -12(%ebp), %eax
    pushl   %eax
    pushl   -16(%ebp)
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    call    readInt
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -16(%ebp), %eax
    pushl   %eax
    popl    %eax
    incl    (%eax)
    jmp .L27
.L29:
    pushl   -8(%ebp)
    pushl   -12(%ebp)
    call    heapSort
    popl    %ebx
    popl    %ebx
    pushl   $0
    popl    -20(%ebp)
.L32:
    pushl   -20(%ebp)
    leal    -12(%ebp), %eax
    pushl   %eax
    popl    %eax
    pushl   4(%eax)
    popl    %eax
    cmpl    %eax, 0(%esp)
    jge .L35
    pushl   $1
    jmp .L36
.L35:
    pushl   $0
.L36:
    popl    %eax
    testl   %eax, %eax
    jnz  .L33
    jmp .L34
.L33:
    leal    -12(%ebp), %eax
    pushl   %eax
    pushl   -20(%ebp)
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    popl    %eax
    pushl   (%eax)
    popl    -24(%ebp)
    pushl   -24(%ebp)
    call    printInt
    popl    %ebx
    leal    -20(%ebp), %eax
    pushl   %eax
    popl    %eax
    incl    (%eax)
    jmp .L32
.L34:
    pushl   $0
    popl    %eax
    leave
    ret
