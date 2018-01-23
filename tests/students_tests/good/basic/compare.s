.globl main

.LC0:
.string "4"
.LC1:
.string "5"
.LC2:
.string "6"
.LC3:
.string "7"

main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   $1
    pushl   $1
    popl    %eax
    cmpl    %eax, 0(%esp)
    jg  .L2
    pushl   $1
    jmp .L3
.L2:
    pushl   $0
.L3:
    popl    %eax
    testl   %eax, %eax
    jnz  .L0
    jmp .L1
.L0:
    pushl   $.LC0
    call    printString
    popl    %ebx
.L1:
    pushl   $1
    pushl   $1
    popl    %eax
    cmpl    %eax, 0(%esp)
    jl  .L6
    pushl   $1
    jmp .L7
.L6:
    pushl   $0
.L7:
    popl    %eax
    testl   %eax, %eax
    jnz  .L4
    jmp .L5
.L4:
    pushl   $.LC0
    call    printString
    popl    %ebx
.L5:
    pushl   $1
    pushl   $1
    popl    %eax
    cmpl    %eax, 0(%esp)
    jle .L10
    pushl   $1
    jmp .L11
.L10:
    pushl   $0
.L11:
    popl    %eax
    testl   %eax, %eax
    jnz  .L8
    jmp .L9
.L8:
    pushl   $.LC1
    call    printString
    popl    %ebx
.L9:
    pushl   $1
    pushl   $1
    popl    %eax
    cmpl    %eax, 0(%esp)
    jge .L14
    pushl   $1
    jmp .L15
.L14:
    pushl   $0
.L15:
    popl    %eax
    testl   %eax, %eax
    jnz  .L12
    jmp .L13
.L12:
    pushl   $.LC1
    call    printString
    popl    %ebx
.L13:
    pushl   $1
    pushl   $2
    popl    %eax
    cmpl    %eax, 0(%esp)
    jge .L18
    pushl   $1
    jmp .L19
.L18:
    pushl   $0
.L19:
    popl    %eax
    testl   %eax, %eax
    jnz  .L16
    jmp .L17
.L16:
    pushl   $.LC2
    call    printString
    popl    %ebx
.L17:
    pushl   $2
    pushl   $1
    popl    %eax
    cmpl    %eax, 0(%esp)
    jle .L22
    pushl   $1
    jmp .L23
.L22:
    pushl   $0
.L23:
    popl    %eax
    testl   %eax, %eax
    jnz  .L20
    jmp .L21
.L20:
    pushl   $.LC2
    call    printString
    popl    %ebx
.L21:
    pushl   $1
    pushl   $2
    popl    %eax
    cmpl    %eax, 0(%esp)
    jle .L26
    pushl   $1
    jmp .L27
.L26:
    pushl   $0
.L27:
    popl    %eax
    testl   %eax, %eax
    jnz  .L24
    jmp .L25
.L24:
    pushl   $.LC3
    call    printString
    popl    %ebx
.L25:
    pushl   $2
    pushl   $1
    popl    %eax
    cmpl    %eax, 0(%esp)
    jge .L30
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
    pushl   $.LC3
    call    printString
    popl    %ebx
.L29:
    pushl   $0
    popl    %eax
    leave
    ret
