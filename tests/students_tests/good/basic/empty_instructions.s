.globl main


main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   $0
    popl    %eax
    leave
    ret
