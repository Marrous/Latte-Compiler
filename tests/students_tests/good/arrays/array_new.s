.globl main


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
    pushl   $0
    popl    %eax
    leave
    ret
