.globl main

.LC0:
.string "&&"
.LC1:
.string "||"
.LC2:
.string "!"
.LC3:
.string "false"
.LC4:
.string "true"

main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   $.LC0
    call    printString
    popl    %ebx
    pushl   $1
    popl    %eax
    neg %eax
    pushl   %eax
    call    test
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L3
    jmp .L1
.L3:
    pushl   $0
    call    test
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L0
    jmp .L1
.L0:
    pushl   $1
    jmp .L2
.L1:
    pushl   $0
.L2:
    call    printBool
    popl    %ebx
    pushl   $2
    popl    %eax
    neg %eax
    pushl   %eax
    call    test
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L7
    jmp .L5
.L7:
    pushl   $1
    call    test
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L4
    jmp .L5
.L4:
    pushl   $1
    jmp .L6
.L5:
    pushl   $0
.L6:
    call    printBool
    popl    %ebx
    pushl   $3
    call    test
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L11
    jmp .L9
.L11:
    pushl   $5
    popl    %eax
    neg %eax
    pushl   %eax
    call    test
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L8
    jmp .L9
.L8:
    pushl   $1
    jmp .L10
.L9:
    pushl   $0
.L10:
    call    printBool
    popl    %ebx
    pushl   $234234
    call    test
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L15
    jmp .L13
.L15:
    pushl   $21321
    call    test
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L12
    jmp .L13
.L12:
    pushl   $1
    jmp .L14
.L13:
    pushl   $0
.L14:
    call    printBool
    popl    %ebx
    pushl   $.LC1
    call    printString
    popl    %ebx
    pushl   $1
    popl    %eax
    neg %eax
    pushl   %eax
    call    test
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L16
    jmp .L19
.L19:
    pushl   $0
    call    test
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L16
    jmp .L17
.L16:
    pushl   $1
    jmp .L18
.L17:
    pushl   $0
.L18:
    call    printBool
    popl    %ebx
    pushl   $2
    popl    %eax
    neg %eax
    pushl   %eax
    call    test
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L20
    jmp .L23
.L23:
    pushl   $1
    call    test
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L20
    jmp .L21
.L20:
    pushl   $1
    jmp .L22
.L21:
    pushl   $0
.L22:
    call    printBool
    popl    %ebx
    pushl   $3
    call    test
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L24
    jmp .L27
.L27:
    pushl   $5
    popl    %eax
    neg %eax
    pushl   %eax
    call    test
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L24
    jmp .L25
.L24:
    pushl   $1
    jmp .L26
.L25:
    pushl   $0
.L26:
    call    printBool
    popl    %ebx
    pushl   $234234
    call    test
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L28
    jmp .L31
.L31:
    pushl   $21321
    call    test
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L28
    jmp .L29
.L28:
    pushl   $1
    jmp .L30
.L29:
    pushl   $0
.L30:
    call    printBool
    popl    %ebx
    pushl   $.LC2
    call    printString
    popl    %ebx
    pushl   $1
    call    printBool
    popl    %ebx
    pushl   $0
    call    printBool
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
    jnz  .L33
    jmp .L32
.L32:
    pushl   $.LC3
    call    printString
    popl    %ebx
    jmp .L34
.L33:
    pushl   $.LC4
    call    printString
    popl    %ebx
.L34:
    leave
    ret
test:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   8(%ebp)
    call    printInt
    popl    %ebx
    pushl   8(%ebp)
    pushl   $0
    popl    %eax
    cmpl    %eax, 0(%esp)
    jle .L35
    pushl   $1
    jmp .L36
.L35:
    pushl   $0
.L36:
    popl    %eax
    leave
    ret
