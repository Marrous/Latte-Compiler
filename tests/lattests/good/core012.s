.globl main

.LC0:
.string "string"
.LC1:
.string " "
.LC2:
.string "concatenation"
.LC3:
.string "true"
.LC4:
.string "false"

main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $8, %esp
    pushl   $56
    popl    -4(%ebp)
    pushl   $23
    popl    %eax
    neg %eax
    pushl   %eax
    popl    -8(%ebp)
    pushl   -4(%ebp)
    pushl   -8(%ebp)
    popl    %eax
    popl    %ebx
    addl    %ebx, %eax
    pushl   %eax
    call    printInt
    popl    %ebx
    pushl   -4(%ebp)
    pushl   -8(%ebp)
    popl    %eax
    popl    %ebx
    subl    %eax, %ebx
    pushl   %ebx
    call    printInt
    popl    %ebx
    pushl   -4(%ebp)
    pushl   -8(%ebp)
    popl    %eax
    popl    %ebx
    imul    %ebx, %eax
    pushl   %eax
    call    printInt
    popl    %ebx
    pushl   $45
    pushl   $2
    popl    %ebx
    popl    %eax
    movl    %eax, %edx
    sar    $31, %edx
    idiv    %ebx
    pushl   %eax
    call    printInt
    popl    %ebx
    pushl   $78
    pushl   $3
    popl    %ebx
    popl    %eax
    movl    %eax, %edx
    sar    $31, %edx
    idiv    %ebx
    pushl   %edx
    call    printInt
    popl    %ebx
    pushl   -4(%ebp)
    pushl   -8(%ebp)
    popl    %eax
    popl    %ebx
    subl    %eax, %ebx
    pushl   %ebx
    pushl   -4(%ebp)
    pushl   -8(%ebp)
    popl    %eax
    popl    %ebx
    addl    %ebx, %eax
    pushl   %eax
    popl    %eax
    cmpl    %eax, 0(%esp)
    jle .L0
    pushl   $1
    jmp .L1
.L0:
    pushl   $0
.L1:
    call    printBool
    popl    %ebx
    pushl   -4(%ebp)
    pushl   -8(%ebp)
    popl    %ebx
    popl    %eax
    movl    %eax, %edx
    sar    $31, %edx
    idiv    %ebx
    pushl   %eax
    pushl   -4(%ebp)
    pushl   -8(%ebp)
    popl    %eax
    popl    %ebx
    imul    %ebx, %eax
    pushl   %eax
    popl    %eax
    cmpl    %eax, 0(%esp)
    jg  .L2
    pushl   $1
    jmp .L3
.L2:
    pushl   $0
.L3:
    call    printBool
    popl    %ebx
    pushl   $.LC0
    pushl   $.LC1
    popl    %ebx
    popl    %ecx
    pushl   %ebx
    pushl   %ecx
    call    addStrings
    popl    %ebx
    popl    %ebx
    pushl   %eax
    pushl   $.LC2
    popl    %ebx
    popl    %ecx
    pushl   %ebx
    pushl   %ecx
    call    addStrings
    popl    %ebx
    popl    %ebx
    pushl   %eax
    call    printString
    popl    %ebx
    pushl   $0
    popl    %eax
    leave
    ret
printBool:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   8(%ebp)
    popl    %eax
    testl   %eax, %eax
    jnz  .L4
    jmp .L5
.L4:
    pushl   $.LC3
    call    printString
    popl    %ebx
    leave
    ret
    jmp .L6
.L5:
    pushl   $.LC4
    call    printString
    popl    %ebx
    leave
    ret
.L6:
    leave
    ret
