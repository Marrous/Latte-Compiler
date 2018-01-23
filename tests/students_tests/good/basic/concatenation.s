.globl main

.LC0:
.string "a"
.LC1:
.string "b"

main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
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
    call    printString
    popl    %ebx
    pushl   $0
    popl    %eax
    leave
    ret
