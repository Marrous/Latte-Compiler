.globl main


main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $12, %esp
    pushl   $0
    popl    -4(%ebp)
    pushl   -4(%ebp)
    call    printInt
    popl    %ebx
    pushl   $1
    popl    -8(%ebp)
    pushl   -8(%ebp)
    call    printInt
    popl    %ebx
    pushl   -4(%ebp)
    call    printInt
    popl    %ebx
    pushl   $2
    popl    -8(%ebp)
    pushl   -8(%ebp)
    call    printInt
    popl    %ebx
    pushl   -4(%ebp)
    call    printInt
    popl    %ebx
    pushl   $0
    popl    %eax
    leave
    ret
