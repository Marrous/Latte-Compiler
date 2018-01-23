.globl main


.IntQueueVTable: .int IntQueue$isEmpty,IntQueue$insert,IntQueue$first,IntQueue$rmFirst,IntQueue$size
.NodeVTable: .int Node$setElem,Node$setNext,Node$getElem,Node$getNext
Node$setElem:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    leal    12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    pushl   8(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leave
    ret
Node$setNext:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    leal    12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    8(%ebx), %eax
    pushl   %eax
    pushl   8(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leave
    ret
Node$getElem:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    leal    8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    popl    %eax
    leave
    ret
Node$getNext:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    leal    8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    8(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    popl    %eax
    leave
    ret
IntQueue$isEmpty:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    leal    8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    pushl   $0
    popl    %eax
    cmpl    %eax, 0(%esp)
    jne .L0
    pushl   $1
    jmp .L1
.L0:
    pushl   $0
.L1:
    popl    %eax
    leave
    ret
IntQueue$insert:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $4, %esp
    pushl   $4
    pushl   $12
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.NodeVTable, (%eax)
    pushl   %eax
    popl    -4(%ebp)
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   8(%ebp)
    call    *0(%edx)
    popl    %ebx
    popl    %ebx
    leal    12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    call    *0(%edx)
    pushl   %eax
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L2
    jmp .L3
.L2:
    leal    12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    pushl   -4(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    jmp .L4
.L3:
    leal    12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    8(%ebx), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   -4(%ebp)
    call    *4(%edx)
    popl    %ebx
    popl    %ebx
.L4:
    leal    12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    8(%ebx), %eax
    pushl   %eax
    pushl   -4(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leave
    ret
IntQueue$first:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    leal    8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    call    *8(%edx)
    pushl   %eax
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    %eax
    leave
    ret
IntQueue$rmFirst:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    leal    8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    leal    8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    call    *12(%edx)
    pushl   %eax
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leave
    ret
IntQueue$size:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $8, %esp
    leal    8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    popl    -4(%ebp)
    pushl   $0
    popl    -8(%ebp)
.L5:
    pushl   -4(%ebp)
    pushl   $0
    popl    %eax
    cmpl    %eax, 0(%esp)
    je  .L8
    pushl   $1
    jmp .L9
.L8:
    pushl   $0
.L9:
    popl    %eax
    testl   %eax, %eax
    jnz  .L6
    jmp .L7
.L6:
    leal    -4(%ebp), %eax
    pushl   %eax
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    call    *12(%edx)
    pushl   %eax
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -8(%ebp), %eax
    pushl   %eax
    popl    %eax
    incl    (%eax)
    jmp .L5
.L7:
    pushl   -8(%ebp)
    popl    %eax
    leave
    ret
f:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   8(%ebp)
    pushl   8(%ebp)
    popl    %eax
    popl    %ebx
    imul    %ebx, %eax
    pushl   %eax
    pushl   $3
    popl    %eax
    popl    %ebx
    addl    %ebx, %eax
    pushl   %eax
    popl    %eax
    leave
    ret
main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $4, %esp
    pushl   $4
    pushl   $12
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.IntQueueVTable, (%eax)
    pushl   %eax
    popl    -4(%ebp)
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   $3
    call    f
    popl    %ebx
    pushl   %eax
    call    *4(%edx)
    popl    %ebx
    popl    %ebx
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   $5
    call    *4(%edx)
    popl    %ebx
    popl    %ebx
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   $7
    call    *4(%edx)
    popl    %ebx
    popl    %ebx
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    call    *8(%edx)
    pushl   %eax
    popl    %ebx
    popl    %ebx
    pushl   %eax
    call    printInt
    popl    %ebx
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    call    *12(%edx)
    popl    %ebx
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    call    *16(%edx)
    pushl   %eax
    popl    %ebx
    popl    %ebx
    pushl   %eax
    call    printInt
    popl    %ebx
    pushl   $0
    popl    %eax
    leave
    ret
