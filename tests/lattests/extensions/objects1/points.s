.globl main


.Point2VTable: .int Point2$move,Point2$getX,Point2$getY
.Point3VTable: .int Point2$move,Point2$getX,Point2$getY,Point3$moveZ,Point3$getZ
.Point4VTable: .int Point2$move,Point2$getX,Point2$getY,Point3$moveZ,Point3$getZ,Point4$moveW,Point4$getW
Point2$move:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    leal    16(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    leal    16(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    pushl   12(%ebp)
    popl    %eax
    popl    %ebx
    addl    %ebx, %eax
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    16(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    8(%ebx), %eax
    pushl   %eax
    leal    16(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    8(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    pushl   8(%ebp)
    popl    %eax
    popl    %ebx
    addl    %ebx, %eax
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leave
    ret
Point2$getX:
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
Point2$getY:
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
Point3$moveZ:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    leal    12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    12(%ebx), %eax
    pushl   %eax
    leal    12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    12(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    pushl   8(%ebp)
    popl    %eax
    popl    %ebx
    addl    %ebx, %eax
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leave
    ret
Point3$getZ:
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
Point4$moveW:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    leal    12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    16(%ebx), %eax
    pushl   %eax
    leal    12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    16(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    pushl   8(%ebp)
    popl    %eax
    popl    %ebx
    addl    %ebx, %eax
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leave
    ret
Point4$getW:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    leal    8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    16(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    popl    %eax
    leave
    ret
main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $12, %esp
    pushl   $4
    pushl   $16
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.Point3VTable, (%eax)
    pushl   %eax
    popl    -4(%ebp)
    pushl   $4
    pushl   $16
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.Point3VTable, (%eax)
    pushl   %eax
    popl    -8(%ebp)
    pushl   $4
    pushl   $20
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.Point4VTable, (%eax)
    pushl   %eax
    popl    -12(%ebp)
    leal    -8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   $2
    pushl   $4
    call    *0(%edx)
    popl    %ebx
    popl    %ebx
    popl    %ebx
    leal    -8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   $7
    call    *12(%edx)
    popl    %ebx
    popl    %ebx
    leal    -4(%ebp), %eax
    pushl   %eax
    pushl   -8(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   $3
    pushl   $5
    call    *0(%edx)
    popl    %ebx
    popl    %ebx
    popl    %ebx
    leal    -12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   $1
    pushl   $3
    call    *0(%edx)
    popl    %ebx
    popl    %ebx
    popl    %ebx
    leal    -12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   $6
    call    *12(%edx)
    popl    %ebx
    popl    %ebx
    leal    -12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    pushl   $2
    call    *20(%edx)
    popl    %ebx
    popl    %ebx
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
    call    printInt
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
    leal    -8(%ebp), %eax
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
    leal    -12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    call    *24(%edx)
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
