.globl main


maxHeapify:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $12, %esp
    pushl   12(%ebp)
    popl    -4(%ebp)
    leal    16(%ebp), %eax
    pushl   %eax
    pushl   -4(%ebp)
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    popl    %eax
    pushl   (%eax)
    popl    -8(%ebp)
.L0:
    pushl   $2
    pushl   -4(%ebp)
    popl    %eax
    popl    %ebx
    imul    %ebx, %eax
    pushl   %eax
    pushl   8(%ebp)
    popl    %eax
    cmpl    %eax, 0(%esp)
    jg  .L3
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
    pushl   $2
    pushl   -4(%ebp)
    popl    %eax
    popl    %ebx
    imul    %ebx, %eax
    pushl   %eax
    popl    -12(%ebp)
    pushl   -12(%ebp)
    pushl   8(%ebp)
    popl    %eax
    cmpl    %eax, 0(%esp)
    jge .L7
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
    leal    16(%ebp), %eax
    pushl   %eax
    pushl   -12(%ebp)
    pushl   $1
    popl    %eax
    popl    %ebx
    addl    %ebx, %eax
    pushl   %eax
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
    jle .L11
    pushl   $1
    jmp .L12
.L11:
    pushl   $0
.L12:
    popl    %eax
    testl   %eax, %eax
    jnz  .L9
    jmp .L10
.L9:
    leal    -12(%ebp), %eax
    pushl   %eax
    popl    %eax
    incl    (%eax)
.L10:
.L6:
    pushl   -8(%ebp)
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
    jl  .L16
    pushl   $1
    jmp .L17
.L16:
    pushl   $0
.L17:
    popl    %eax
    testl   %eax, %eax
    jnz  .L13
    jmp .L14
.L13:
    leal    16(%ebp), %eax
    pushl   %eax
    pushl   -4(%ebp)
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    pushl   -8(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -4(%ebp), %eax
    pushl   %eax
    pushl   8(%ebp)
    pushl   $1
    popl    %eax
    popl    %ebx
    addl    %ebx, %eax
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    jmp .L15
.L14:
    leal    16(%ebp), %eax
    pushl   %eax
    pushl   -4(%ebp)
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
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
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -4(%ebp), %eax
    pushl   %eax
    pushl   -12(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
.L15:
    jmp .L0
.L2:
    pushl   -4(%ebp)
    pushl   8(%ebp)
    popl    %eax
    cmpl    %eax, 0(%esp)
    jg  .L20
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
    leal    16(%ebp), %eax
    pushl   %eax
    pushl   -4(%ebp)
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    pushl   -8(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
.L19:
    leave
    ret
main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $28, %esp
    pushl   $0
    popl    -4(%ebp)
    pushl   $4
    pushl   $0
    call    calloc
    popl    %ebx
    popl    %ecx
    pushl   %ebx
    pushl   %eax
    popl    -12(%ebp)
    popl    -8(%ebp)
    leal    -4(%ebp), %eax
    pushl   %eax
    call    readInt
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -12(%ebp), %eax
    pushl   %eax
    pushl   $4
    pushl   -4(%ebp)
    call    calloc
    popl    %ebx
    popl    %ecx
    pushl   %ebx
    pushl   %eax
    popl    %eax
    popl    %ebx
    popl    %ecx
    movl    %eax, (%ecx)
    addl    $4, %ecx
    movl    %ebx, (%ecx)
    pushl   $0
    popl    -16(%ebp)
.L22:
    pushl   -16(%ebp)
    leal    -12(%ebp), %eax
    pushl   %eax
    popl    %eax
    pushl   4(%eax)
    popl    %eax
    cmpl    %eax, 0(%esp)
    jge .L25
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
    jmp .L22
.L24:
    leal    -16(%ebp), %eax
    pushl   %eax
    pushl   -4(%ebp)
    pushl   $1
    popl    %eax
    popl    %ebx
    subl    %eax, %ebx
    pushl   %ebx
    pushl   $2
    popl    %ebx
    popl    %eax
    movl    %eax, %edx
    sar    $31, %edx
    idiv    %ebx
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
.L27:
    pushl   -16(%ebp)
    pushl   $0
    popl    %eax
    cmpl    %eax, 0(%esp)
    jl  .L30
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
    pushl   -8(%ebp)
    pushl   -12(%ebp)
    pushl   -16(%ebp)
    pushl   -4(%ebp)
    pushl   $1
    popl    %eax
    popl    %ebx
    subl    %eax, %ebx
    pushl   %ebx
    call    maxHeapify
    popl    %ebx
    popl    %ebx
    popl    %ebx
    popl    %ebx
    leal    -16(%ebp), %eax
    pushl   %eax
    popl    %eax
    decl    (%eax)
    jmp .L27
.L29:
    leal    -16(%ebp), %eax
    pushl   %eax
    pushl   -4(%ebp)
    pushl   $1
    popl    %eax
    popl    %ebx
    subl    %eax, %ebx
    pushl   %ebx
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
.L32:
    pushl   -16(%ebp)
    pushl   $1
    popl    %eax
    cmpl    %eax, 0(%esp)
    jl  .L35
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
    pushl   -16(%ebp)
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    popl    %eax
    pushl   (%eax)
    popl    -20(%ebp)
    leal    -12(%ebp), %eax
    pushl   %eax
    pushl   -16(%ebp)
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    leal    -12(%ebp), %eax
    pushl   %eax
    pushl   $0
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
    leal    -12(%ebp), %eax
    pushl   %eax
    pushl   $0
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    pushl   -20(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    pushl   -8(%ebp)
    pushl   -12(%ebp)
    pushl   $0
    pushl   -16(%ebp)
    pushl   $1
    popl    %eax
    popl    %ebx
    subl    %eax, %ebx
    pushl   %ebx
    call    maxHeapify
    popl    %ebx
    popl    %ebx
    popl    %ebx
    popl    %ebx
    leal    -16(%ebp), %eax
    pushl   %eax
    popl    %eax
    decl    (%eax)
    jmp .L32
.L34:
    leal    -16(%ebp), %eax
    pushl   %eax
    pushl   $0
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
.L37:
    pushl   -16(%ebp)
    pushl   -4(%ebp)
    pushl   $1
    popl    %eax
    popl    %ebx
    subl    %eax, %ebx
    pushl   %ebx
    popl    %eax
    cmpl    %eax, 0(%esp)
    jge .L40
    pushl   $1
    jmp .L41
.L40:
    pushl   $0
.L41:
    popl    %eax
    testl   %eax, %eax
    jnz  .L38
    jmp .L39
.L38:
    leal    -12(%ebp), %eax
    pushl   %eax
    pushl   -16(%ebp)
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    popl    %eax
    pushl   (%eax)
    leal    -12(%ebp), %eax
    pushl   %eax
    pushl   -16(%ebp)
    pushl   $1
    popl    %eax
    popl    %ebx
    addl    %ebx, %eax
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    popl    %eax
    pushl   (%eax)
    popl    %eax
    cmpl    %eax, 0(%esp)
    jle .L44
    pushl   $1
    jmp .L45
.L44:
    pushl   $0
.L45:
    popl    %eax
    testl   %eax, %eax
    jnz  .L42
    jmp .L43
.L42:
    call    error
.L43:
    leal    -16(%ebp), %eax
    pushl   %eax
    popl    %eax
    incl    (%eax)
    jmp .L37
.L39:
    pushl   $0
    popl    -20(%ebp)
.L46:
    pushl   -20(%ebp)
    leal    -12(%ebp), %eax
    pushl   %eax
    popl    %eax
    pushl   4(%eax)
    popl    %eax
    cmpl    %eax, 0(%esp)
    jge .L49
    pushl   $1
    jmp .L50
.L49:
    pushl   $0
.L50:
    popl    %eax
    testl   %eax, %eax
    jnz  .L47
    jmp .L48
.L47:
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
    jmp .L46
.L48:
    pushl   $0
    popl    %eax
    leave
    ret
