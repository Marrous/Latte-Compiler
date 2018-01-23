.globl main

.LC0:
.string "I'm a shape"
.LC1:
.string "I'm just a shape"
.LC2:
.string "I'm really a rectangle"
.LC3:
.string "I'm really a circle"
.LC4:
.string "I'm really a square"
.CircleVTable: .int Shape$tell,Circle$tellAgain
.NodeVTable: .int Node$setElem,Node$setNext,Node$getElem,Node$getNext
.RectangleVTable: .int Shape$tell,Rectangle$tellAgain
.ShapeVTable: .int Shape$tell,Shape$tellAgain
.SquareVTable: .int Shape$tell,Square$tellAgain
.StackVTable: .int Stack$push,Stack$isEmpty,Stack$top,Stack$pop
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
Stack$push:
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
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    leal    12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    call    *4(%edx)
    popl    %ebx
    popl    %ebx
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
    leave
    ret
Stack$isEmpty:
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
Stack$top:
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
Stack$pop:
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
Shape$tell:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   $.LC0
    call    printString
    popl    %ebx
    leave
    ret
Shape$tellAgain:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   $.LC1
    call    printString
    popl    %ebx
    leave
    ret
Rectangle$tellAgain:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   $.LC2
    call    printString
    popl    %ebx
    leave
    ret
Circle$tellAgain:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   $.LC3
    call    printString
    popl    %ebx
    leave
    ret
Square$tellAgain:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   $.LC4
    call    printString
    popl    %ebx
    leave
    ret
main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $8, %esp
    pushl   $4
    pushl   $8
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.StackVTable, (%eax)
    pushl   %eax
    popl    -4(%ebp)
    pushl   $4
    pushl   $4
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.ShapeVTable, (%eax)
    pushl   %eax
    popl    -8(%ebp)
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   -8(%ebp)
    call    *0(%edx)
    popl    %ebx
    popl    %ebx
    leal    -8(%ebp), %eax
    pushl   %eax
    pushl   $4
    pushl   $4
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.RectangleVTable, (%eax)
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   -8(%ebp)
    call    *0(%edx)
    popl    %ebx
    popl    %ebx
    leal    -8(%ebp), %eax
    pushl   %eax
    pushl   $4
    pushl   $4
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.SquareVTable, (%eax)
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   -8(%ebp)
    call    *0(%edx)
    popl    %ebx
    popl    %ebx
    leal    -8(%ebp), %eax
    pushl   %eax
    pushl   $4
    pushl   $4
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.CircleVTable, (%eax)
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   -8(%ebp)
    call    *0(%edx)
    popl    %ebx
    popl    %ebx
.L2:
    leal    -4(%ebp), %eax
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
    jnz  .L4
    jmp .L3
.L3:
    leal    -8(%ebp), %eax
    pushl   %eax
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
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    call    *0(%edx)
    popl    %ebx
    leal    -8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    call    *4(%edx)
    popl    %ebx
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    call    *12(%edx)
    popl    %ebx
    jmp .L2
.L4:
    pushl   $0
    popl    %eax
    leave
    ret
