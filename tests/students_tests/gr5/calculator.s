.globl main


.LiczbaVTable: .int Liczba$value
.MinusVTable: .int Operator$value,Minus$operator
.NodeVTable: .int Node$value
.OperatorVTable: .int Operator$value,Operator$operator
.PlusVTable: .int Operator$value,Plus$operator
.PodzielVTable: .int Operator$value,Podziel$operator
.RazyVTable: .int Operator$value,Razy$operator
main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $4, %esp
    pushl   $4
    call    liczba
    popl    %ebx
    pushl   %eax
    pushl   $3
    call    liczba
    popl    %ebx
    pushl   %eax
    call    minus
    popl    %ebx
    popl    %ebx
    pushl   %eax
    pushl   $2
    call    liczba
    popl    %ebx
    pushl   %eax
    pushl   $4
    call    liczba
    popl    %ebx
    pushl   %eax
    pushl   $2
    call    liczba
    popl    %ebx
    pushl   %eax
    call    podziel
    popl    %ebx
    popl    %ebx
    pushl   %eax
    call    razy
    popl    %ebx
    popl    %ebx
    pushl   %eax
    call    plus
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
    call    *0(%edx)
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
plus:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $4, %esp
    pushl   $4
    pushl   $12
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.PlusVTable, (%eax)
    pushl   %eax
    popl    -4(%ebp)
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    pushl   12(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    8(%ebx), %eax
    pushl   %eax
    pushl   8(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    pushl   -4(%ebp)
    popl    %eax
    leave
    ret
razy:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $4, %esp
    pushl   $4
    pushl   $12
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.RazyVTable, (%eax)
    pushl   %eax
    popl    -4(%ebp)
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    pushl   12(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    8(%ebx), %eax
    pushl   %eax
    pushl   8(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    pushl   -4(%ebp)
    popl    %eax
    leave
    ret
podziel:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $4, %esp
    pushl   $4
    pushl   $12
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.PodzielVTable, (%eax)
    pushl   %eax
    popl    -4(%ebp)
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    pushl   12(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    8(%ebx), %eax
    pushl   %eax
    pushl   8(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    pushl   -4(%ebp)
    popl    %eax
    leave
    ret
minus:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $4, %esp
    pushl   $4
    pushl   $12
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.MinusVTable, (%eax)
    pushl   %eax
    popl    -4(%ebp)
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    pushl   12(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    8(%ebx), %eax
    pushl   %eax
    pushl   8(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    pushl   -4(%ebp)
    popl    %eax
    leave
    ret
liczba:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $4, %esp
    pushl   $4
    pushl   $8
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.LiczbaVTable, (%eax)
    pushl   %eax
    popl    -4(%ebp)
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    pushl   8(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    pushl   -4(%ebp)
    popl    %eax
    leave
    ret
Node$value:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    call    error
    pushl   $0
    popl    %eax
    leave
    ret
Liczba$value:
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
Operator$operator:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    call    error
    pushl   $0
    popl    %eax
    leave
    ret
Operator$value:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    leal    8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
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
    call    *0(%edx)
    pushl   %eax
    popl    %ebx
    popl    %ebx
    pushl   %eax
    leal    8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    8(%ebx), %eax
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
    call    *4(%edx)
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    %eax
    leave
    ret
Plus$operator:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   12(%ebp)
    pushl   8(%ebp)
    popl    %eax
    popl    %ebx
    addl    %ebx, %eax
    pushl   %eax
    popl    %eax
    leave
    ret
Minus$operator:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   12(%ebp)
    pushl   8(%ebp)
    popl    %eax
    popl    %ebx
    subl    %eax, %ebx
    pushl   %ebx
    popl    %eax
    leave
    ret
Razy$operator:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   12(%ebp)
    pushl   8(%ebp)
    popl    %eax
    popl    %ebx
    imul    %ebx, %eax
    pushl   %eax
    popl    %eax
    leave
    ret
Podziel$operator:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   12(%ebp)
    pushl   8(%ebp)
    popl    %ebx
    popl    %eax
    movl    %eax, %edx
    sar    $31, %edx
    idiv    %ebx
    pushl   %eax
    popl    %eax
    leave
    ret
