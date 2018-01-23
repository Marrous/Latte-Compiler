.globl main

.LC0:
.string "abc"

main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $8, %esp
    pushl   $4
    pushl   $1
    call    calloc
    popl    %ebx
    popl    %ecx
    pushl   %ebx
    pushl   %eax
    popl    -8(%ebp)
    popl    -4(%ebp)
    leal    -8(%ebp), %eax
    pushl   %eax
    pushl   $0
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    pushl   $.LC0
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -8(%ebp), %eax
    pushl   %eax
    pushl   $0
    popl    %eax
    popl    %ebx
    movl    (%ebx), %ecx
    leal    (%ecx, %eax, 4), %ebx
    pushl   %ebx
    popl    %eax
    pushl   (%eax)
    call    printString
    popl    %ebx
    pushl   $0
    popl    %eax
    leave
    ret
