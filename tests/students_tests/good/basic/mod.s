.globl main


main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   $5
    pushl   $3
    popl    %ebx
    popl    %eax
    movl    %eax, %edx
    sar    $31, %edx
    idiv    %ebx
    pushl   %edx
    call    printInt
    popl    %ebx
    pushl   $5
    popl    %eax
    neg %eax
    pushl   %eax
    pushl   $3
    popl    %ebx
    popl    %eax
    movl    %eax, %edx
    sar    $31, %edx
    idiv    %ebx
    pushl   %edx
    call    printInt
    popl    %ebx
    pushl   $0
    popl    %eax
    leave
    ret
