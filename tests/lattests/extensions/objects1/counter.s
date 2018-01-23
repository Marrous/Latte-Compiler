.globl main


.CounterVTable: .int Counter$incr,Counter$value
main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $8, %esp
    pushl   $0
    popl    -4(%ebp)
    leal    -4(%ebp), %eax
    pushl   %eax
    pushl   $4
    pushl   $8
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $.CounterVTable, (%eax)
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
    call    *0(%edx)
    popl    %ebx
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    call    *0(%edx)
    popl    %ebx
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    movl    (%ebx), %edx
    pushl   (%eax)
    call    *0(%edx)
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
    popl    -8(%ebp)
    pushl   -8(%ebp)
    call    printInt
    popl    %ebx
    pushl   $0
    popl    %eax
    leave
    ret
Counter$incr:
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
    incl    (%eax)
    leave
    ret
Counter$value:
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
