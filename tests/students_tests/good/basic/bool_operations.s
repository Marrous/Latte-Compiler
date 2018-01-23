.globl main

.LC0:
.string "true"
.LC1:
.string "false"

main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   $1
    call    t
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L3
    jmp .L1
.L3:
    pushl   $2
    call    f
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
    call    b
    popl    %ebx
    pushl   $3
    call    t
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L7
    jmp .L5
.L7:
    pushl   $4
    call    t
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
    call    b
    popl    %ebx
    pushl   $5
    call    t
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L8
    jmp .L11
.L11:
    pushl   $6
    call    t
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
    call    b
    popl    %ebx
    pushl   $7
    call    f
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L15
    jmp .L13
.L15:
    pushl   $8
    call    t
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
    call    b
    popl    %ebx
    pushl   $9
    call    t
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L19
    jmp .L17
.L19:
    pushl   $10
    call    t
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L20
    jmp .L17
.L20:
    pushl   $11
    call    t
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
    call    b
    popl    %ebx
    pushl   $12
    call    f
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L21
    jmp .L24
.L24:
    pushl   $13
    call    f
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L25
    jmp .L22
.L25:
    pushl   $14
    call    t
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L21
    jmp .L22
.L21:
    pushl   $1
    jmp .L23
.L22:
    pushl   $0
.L23:
    call    b
    popl    %ebx
    pushl   $0
    popl    %eax
    leave
    ret
f:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   8(%ebp)
    call    printInt
    popl    %ebx
    pushl   $0
    popl    %eax
    leave
    ret
t:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   8(%ebp)
    call    f
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L27
    jmp .L26
.L26:
    pushl   $1
    jmp .L28
.L27:
    pushl   $0
.L28:
    popl    %eax
    leave
    ret
b:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   8(%ebp)
    popl    %eax
    testl   %eax, %eax
    jnz  .L29
    jmp .L30
.L29:
    pushl   $.LC0
    call    printString
    popl    %ebx
    jmp .L31
.L30:
    pushl   $.LC1
    call    printString
    popl    %ebx
.L31:
    leave
    ret
