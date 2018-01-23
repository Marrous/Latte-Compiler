.globl main


.ListVTable: .int List$makeSingleton,List$getHead,List$getTail,List$cons
.NodeVTable: .int Node$init,Node$isVisited,Node$markAsVisited,Node$getValue,Node$getNeighbours,Node$addNeighbour
.QueueVTable: .int Queue$get,Queue$put,Queue$isEmpty
Node$init:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    leal    12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    pushl   $0
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
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
    leal    12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    12(%ebx), %eax
    pushl   %eax
    pushl   $0
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leave
    ret
Node$isVisited:
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
Node$markAsVisited:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    leal    8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    pushl   $1
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leave
    ret
Node$getValue:
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
Node$getNeighbours:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    leal    8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    12(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    popl    %eax
    leave
    ret
Node$addNeighbour:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $8, %esp
    leal    12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    12(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    pushl   $0
    popl    %eax
    cmpl    %eax, 0(%esp)
    jne .L3
    pushl   $1
    jmp .L4
.L3:
    pushl   $0
.L4:
    popl    %eax
    testl   %eax, %eax
    jnz  .L0
    jmp .L1
.L0:
    leal    12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    12(%ebx), %eax
    pushl   %eax
    pushl   $4
    pushl   $12
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.ListVTable, (%eax)
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    12(%ebx), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   8(%ebp)
    call    *0(%edx)
    popl    %ebx
    popl    %ebx
    jmp .L2
.L1:
    pushl   $4
    pushl   $12
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.ListVTable, (%eax)
    pushl   %eax
    popl    -4(%ebp)
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   8(%ebp)
    leal    12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    12(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    call    *12(%edx)
    popl    %ebx
    popl    %ebx
    popl    %ebx
    leal    12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    12(%ebx), %eax
    pushl   %eax
    pushl   -4(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
.L2:
    leave
    ret
List$makeSingleton:
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
    leal    12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    8(%ebx), %eax
    pushl   %eax
    pushl   $0
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leave
    ret
List$getHead:
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
List$getTail:
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
List$cons:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    leal    16(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    pushl   12(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    16(%ebp), %eax
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
Queue$get:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $4, %esp
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
    jne .L7
    pushl   $1
    jmp .L8
.L7:
    pushl   $0
.L8:
    popl    %eax
    testl   %eax, %eax
    jnz  .L5
    jmp .L6
.L5:
    pushl   $0
    popl    %eax
    leave
    ret
.L6:
    leal    8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    popl    -4(%ebp)
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
    leal    8(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
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
    jne .L11
    pushl   $1
    jmp .L12
.L11:
    pushl   $0
.L12:
    popl    %eax
    testl   %eax, %eax
    jnz  .L9
    jmp .L10
.L9:
    leal    8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    8(%ebx), %eax
    pushl   %eax
    pushl   $0
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
.L10:
    pushl   -4(%ebp)
    popl    %eax
    leave
    ret
Queue$put:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $4, %esp
    pushl   $4
    pushl   $12
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.ListVTable, (%eax)
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
    leal    4(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    pushl   $0
    popl    %eax
    cmpl    %eax, 0(%esp)
    jne .L16
    pushl   $1
    jmp .L17
.L16:
    pushl   $0
.L17:
    popl    %eax
    testl   %eax, %eax
    jnz  .L13
    jmp .L14
.L13:
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
    jmp .L15
.L14:
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
    call    *4(%edx)
    pushl   %eax
    popl    %ebx
    popl    %ebx
    pushl   %eax
    pushl   -4(%ebp)
    call    *12(%edx)
    popl    %ebx
    popl    %ebx
    popl    %ebx
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
.L15:
    leave
    ret
Queue$isEmpty:
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
    jne .L18
    pushl   $1
    jmp .L19
.L18:
    pushl   $0
.L19:
    popl    %eax
    leave
    ret
main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $8, %esp
    call    prepareData
    pushl   %eax
    popl    -4(%ebp)
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    call    *8(%edx)
    popl    %ebx
    pushl   $4
    pushl   $12
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.QueueVTable, (%eax)
    pushl   %eax
    popl    -8(%ebp)
    leal    -8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   -4(%ebp)
    call    *4(%edx)
    popl    %ebx
    popl    %ebx
    pushl   -8(%ebp)
    call    bfs
    popl    %ebx
    pushl   $0
    popl    %eax
    leave
    ret
prepareData:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $36, %esp
    pushl   $4
    pushl   $16
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
    pushl   $1
    call    *0(%edx)
    popl    %ebx
    popl    %ebx
    pushl   $4
    pushl   $16
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.NodeVTable, (%eax)
    pushl   %eax
    popl    -8(%ebp)
    leal    -8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   $2
    call    *0(%edx)
    popl    %ebx
    popl    %ebx
    pushl   $4
    pushl   $16
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.NodeVTable, (%eax)
    pushl   %eax
    popl    -12(%ebp)
    leal    -12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   $3
    call    *0(%edx)
    popl    %ebx
    popl    %ebx
    pushl   $4
    pushl   $16
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.NodeVTable, (%eax)
    pushl   %eax
    popl    -16(%ebp)
    leal    -16(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   $4
    call    *0(%edx)
    popl    %ebx
    popl    %ebx
    pushl   $4
    pushl   $16
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.NodeVTable, (%eax)
    pushl   %eax
    popl    -20(%ebp)
    leal    -20(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   $5
    call    *0(%edx)
    popl    %ebx
    popl    %ebx
    pushl   $4
    pushl   $16
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.NodeVTable, (%eax)
    pushl   %eax
    popl    -24(%ebp)
    leal    -24(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   $6
    call    *0(%edx)
    popl    %ebx
    popl    %ebx
    pushl   $4
    pushl   $16
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.NodeVTable, (%eax)
    pushl   %eax
    popl    -28(%ebp)
    leal    -28(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   $7
    call    *0(%edx)
    popl    %ebx
    popl    %ebx
    pushl   $4
    pushl   $16
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.NodeVTable, (%eax)
    pushl   %eax
    popl    -32(%ebp)
    leal    -32(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   $8
    call    *0(%edx)
    popl    %ebx
    popl    %ebx
    pushl   $4
    pushl   $16
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.NodeVTable, (%eax)
    pushl   %eax
    popl    -36(%ebp)
    leal    -36(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   $9
    call    *0(%edx)
    popl    %ebx
    popl    %ebx
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   -12(%ebp)
    call    *20(%edx)
    popl    %ebx
    popl    %ebx
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   -8(%ebp)
    call    *20(%edx)
    popl    %ebx
    popl    %ebx
    leal    -8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   -12(%ebp)
    call    *20(%edx)
    popl    %ebx
    popl    %ebx
    leal    -12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   -24(%ebp)
    call    *20(%edx)
    popl    %ebx
    popl    %ebx
    leal    -12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   -20(%ebp)
    call    *20(%edx)
    popl    %ebx
    popl    %ebx
    leal    -12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   -16(%ebp)
    call    *20(%edx)
    popl    %ebx
    popl    %ebx
    leal    -16(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   -8(%ebp)
    call    *20(%edx)
    popl    %ebx
    popl    %ebx
    leal    -20(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   -28(%ebp)
    call    *20(%edx)
    popl    %ebx
    popl    %ebx
    leal    -28(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   -32(%ebp)
    call    *20(%edx)
    popl    %ebx
    popl    %ebx
    leal    -32(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   -36(%ebp)
    call    *20(%edx)
    popl    %ebx
    popl    %ebx
    leal    -36(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   -20(%ebp)
    call    *20(%edx)
    popl    %ebx
    popl    %ebx
    pushl   -4(%ebp)
    popl    %eax
    leave
    ret
bfs:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $12, %esp
.L20:
    leal    8(%ebp), %eax
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
    testl   %eax, %eax
    jnz  .L22
    jmp .L21
.L21:
    leal    8(%ebp), %eax
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
    popl    -4(%ebp)
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
    call    printInt
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
    popl    -8(%ebp)
.L23:
    pushl   -8(%ebp)
    pushl   $0
    popl    %eax
    cmpl    %eax, 0(%esp)
    je  .L26
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
    leal    -8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    call    *4(%edx)
    pushl   %eax
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    -12(%ebp)
    leal    -12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    call    *4(%edx)
    pushl   %eax
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    %eax
    testl   %eax, %eax
    jnz  .L29
    jmp .L28
.L28:
    leal    -12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    call    *8(%edx)
    popl    %ebx
    leal    8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   -12(%ebp)
    call    *4(%edx)
    popl    %ebx
    popl    %ebx
.L29:
    leal    -8(%ebp), %eax
    pushl   %eax
    leal    -8(%ebp), %eax
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
    popl    %ebx
    movl    %eax, (%ebx)
    jmp .L23
.L25:
    jmp .L20
.L22:
    leave
    ret
