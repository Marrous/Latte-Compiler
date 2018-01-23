.globl main

.LC0:
.string "\\a\\n\n\tb\""

main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   $.LC0
    call    printString
    popl    %ebx
    pushl   $0
    popl    %eax
    leave
    ret
