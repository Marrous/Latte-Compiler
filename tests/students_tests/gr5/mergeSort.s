.globl main

.LC0:
.string "robimy liste do mergeSorta:"
.LC1:
.string "wygenerowal liste 2kierunkowa dziwna dlugosci :"
.LC2:
.string "__________"
.LC3:
.string "idziemy na koniec listy (ma byc nierosnaco): "

main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $4, %esp
    pushl   $30
    popl    -4(%ebp)
    pushl   -4(%ebp)
    call    testMergeSort
    popl    %ebx
    pushl   $0
    popl    %eax
    leave
    ret
testMergeSort:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $8, %esp
    pushl   8(%ebp)
    pushl   $1
    call    generujTablicoListeDoSortowaniaMerge13co7Malejaco
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    -4(%ebp)
    pushl   -4(%ebp)
    pushl   $0
    pushl   8(%ebp)
    call    mergeSort
    popl    %ebx
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    -8(%ebp)
    pushl   -8(%ebp)
    pushl   8(%ebp)
    call    przejdzSieNaKoniecIWypisuj
    popl    %ebx
    popl    %ebx
    pushl   %eax
    leave
    ret
mergeSort:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp
    pushl   $0
    popl    -4(%ebp)
    pushl   $0
    popl    -8(%ebp)
    pushl   8(%ebp)
    pushl   12(%ebp)
    popl    %eax
    popl    %ebx
    subl    %eax, %ebx
    pushl   %ebx
    pushl   $1
    popl    %eax
    cmpl    %eax, 0(%esp)
    jle .L2
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
    pushl   8(%ebp)
    pushl   12(%ebp)
    popl    %eax
    popl    %ebx
    subl    %eax, %ebx
    pushl   %ebx
    pushl   $2
    popl    %ebx
    popl    %eax
    movl    %eax, %edx
    sar    $31, %edx
    idiv    %ebx
    pushl   %eax
    pushl   12(%ebp)
    popl    %eax
    popl    %ebx
    addl    %ebx, %eax
    pushl   %eax
    popl    -12(%ebp)
    leal    -4(%ebp), %eax
    pushl   %eax
    pushl   16(%ebp)
    pushl   12(%ebp)
    pushl   -12(%ebp)
    call    mergeSort
    popl    %ebx
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -8(%ebp), %eax
    pushl   %eax
    pushl   16(%ebp)
    pushl   -12(%ebp)
    pushl   8(%ebp)
    call    mergeSort
    popl    %ebx
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    pushl   -4(%ebp)
    pushl   -12(%ebp)
    pushl   12(%ebp)
    popl    %eax
    popl    %ebx
    subl    %eax, %ebx
    pushl   %ebx
    pushl   -8(%ebp)
    pushl   8(%ebp)
    pushl   -12(%ebp)
    popl    %eax
    popl    %ebx
    subl    %eax, %ebx
    pushl   %ebx
    call    scalaj
    popl    %ebx
    popl    %ebx
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    %eax
    leave
    ret
.L1:
    pushl   $4
    pushl   $16
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $0, (%eax)
    pushl   %eax
    popl    -12(%ebp)
    leal    -12(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    12(%ebx), %eax
    pushl   %eax
    pushl   16(%ebp)
    pushl   12(%ebp)
    call    pokazWartosc
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    pushl   -12(%ebp)
    popl    %eax
    leave
    ret
scalaj:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $24, %esp
    pushl   $0
    popl    -4(%ebp)
    pushl   $0
    popl    -8(%ebp)
    pushl   $0
    popl    -12(%ebp)
    pushl   16(%ebp)
    pushl   8(%ebp)
    popl    %eax
    popl    %ebx
    addl    %ebx, %eax
    pushl   %eax
    pushl   $0
    call    generujTablicoListeDoSortowaniaMerge13co7Malejaco
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    -16(%ebp)
    pushl   20(%ebp)
    pushl   -4(%ebp)
    call    pokazWartosc
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    -20(%ebp)
    pushl   12(%ebp)
    pushl   -8(%ebp)
    call    pokazWartosc
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    -24(%ebp)
.L4:
    pushl   -12(%ebp)
    pushl   16(%ebp)
    pushl   8(%ebp)
    popl    %eax
    popl    %ebx
    addl    %ebx, %eax
    pushl   %eax
    popl    %eax
    cmpl    %eax, 0(%esp)
    jge .L7
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
    pushl   -4(%ebp)
    pushl   16(%ebp)
    popl    %eax
    cmpl    %eax, 0(%esp)
    jne .L12
    pushl   $1
    jmp .L13
.L12:
    pushl   $0
.L13:
    popl    %eax
    testl   %eax, %eax
    jnz  .L9
    jmp .L10
.L9:
    leal    -20(%ebp), %eax
    pushl   %eax
    pushl   $1
    popl    %eax
    neg %eax
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    jmp .L11
.L10:
    leal    -20(%ebp), %eax
    pushl   %eax
    pushl   20(%ebp)
    pushl   -4(%ebp)
    call    pokazWartosc
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
.L11:
    pushl   -8(%ebp)
    pushl   8(%ebp)
    popl    %eax
    cmpl    %eax, 0(%esp)
    jne .L17
    pushl   $1
    jmp .L18
.L17:
    pushl   $0
.L18:
    popl    %eax
    testl   %eax, %eax
    jnz  .L14
    jmp .L15
.L14:
    leal    -24(%ebp), %eax
    pushl   %eax
    pushl   $1
    popl    %eax
    neg %eax
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    jmp .L16
.L15:
    leal    -24(%ebp), %eax
    pushl   %eax
    pushl   12(%ebp)
    pushl   -8(%ebp)
    call    pokazWartosc
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
.L16:
    pushl   -24(%ebp)
    pushl   -20(%ebp)
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
    jnz  .L19
    jmp .L20
.L19:
    leal    -8(%ebp), %eax
    pushl   %eax
    popl    %eax
    incl    (%eax)
    pushl   -16(%ebp)
    pushl   -12(%ebp)
    pushl   -24(%ebp)
    call    ladujWartosc
    popl    %ebx
    popl    %ebx
    popl    %ebx
    jmp .L21
.L20:
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    incl    (%eax)
    pushl   -16(%ebp)
    pushl   -12(%ebp)
    pushl   -20(%ebp)
    call    ladujWartosc
    popl    %ebx
    popl    %ebx
    popl    %ebx
.L21:
    leal    -12(%ebp), %eax
    pushl   %eax
    popl    %eax
    incl    (%eax)
    jmp .L4
.L6:
    pushl   -16(%ebp)
    popl    %eax
    leave
    ret
pokazWartosc:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $8, %esp
    pushl   $0
    popl    -4(%ebp)
    pushl   12(%ebp)
    popl    -8(%ebp)
.L24:
    pushl   -4(%ebp)
    pushl   8(%ebp)
    popl    %eax
    cmpl    %eax, 0(%esp)
    je  .L27
    pushl   $1
    jmp .L28
.L27:
    pushl   $0
.L28:
    popl    %eax
    testl   %eax, %eax
    jnz  .L25
    jmp .L26
.L25:
    leal    -8(%ebp), %eax
    pushl   %eax
    leal    -8(%ebp), %eax
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
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    incl    (%eax)
    jmp .L24
.L26:
    leal    -8(%ebp), %eax
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
ladujWartosc:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $8, %esp
    pushl   $0
    popl    -4(%ebp)
    pushl   16(%ebp)
    popl    -8(%ebp)
.L29:
    pushl   -4(%ebp)
    pushl   12(%ebp)
    popl    %eax
    cmpl    %eax, 0(%esp)
    je  .L32
    pushl   $1
    jmp .L33
.L32:
    pushl   $0
.L33:
    popl    %eax
    testl   %eax, %eax
    jnz  .L30
    jmp .L31
.L30:
    leal    -8(%ebp), %eax
    pushl   %eax
    leal    -8(%ebp), %eax
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
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    incl    (%eax)
    jmp .L29
.L31:
    leal    -8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    12(%ebx), %eax
    pushl   %eax
    pushl   8(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leave
    ret
generujTablicoListeDoSortowaniaMerge13co7Malejaco:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp
    pushl   8(%ebp)
    popl    %eax
    testl   %eax, %eax
    jnz  .L34
    jmp .L35
.L34:
    pushl   $.LC0
    call    printString
    popl    %ebx
.L35:
    pushl   $4
    pushl   $16
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $0, (%eax)
    pushl   %eax
    popl    -4(%ebp)
    pushl   $0
    popl    -8(%ebp)
    pushl   $0
    popl    -12(%ebp)
    leal    -8(%ebp), %eax
    pushl   %eax
    pushl   -4(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    pushl   $1
    popl    -16(%ebp)
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    12(%ebx), %eax
    pushl   %eax
    pushl   $0
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    pushl   8(%ebp)
    popl    %eax
    testl   %eax, %eax
    jnz  .L36
    jmp .L37
.L36:
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    12(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    call    printInt
    popl    %ebx
.L37:
.L38:
    pushl   -16(%ebp)
    pushl   12(%ebp)
    popl    %eax
    cmpl    %eax, 0(%esp)
    je  .L41
    pushl   $1
    jmp .L42
.L41:
    pushl   $0
.L42:
    popl    %eax
    testl   %eax, %eax
    jnz  .L39
    jmp .L40
.L39:
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    pushl   $0
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    8(%ebx), %eax
    pushl   %eax
    pushl   $4
    pushl   $16
    call    calloc
    popl    %ebx
    popl    %ebx
    movl    $0, (%eax)
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -12(%ebp), %eax
    pushl   %eax
    pushl   -8(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -8(%ebp), %eax
    pushl   %eax
    leal    -8(%ebp), %eax
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
    pushl   -16(%ebp)
    pushl   $5
    popl    %ebx
    popl    %eax
    movl    %eax, %edx
    sar    $31, %edx
    idiv    %ebx
    pushl   %edx
    pushl   $3
    popl    %eax
    cmpl    %eax, 0(%esp)
    jne .L46
    pushl   $1
    jmp .L47
.L46:
    pushl   $0
.L47:
    popl    %eax
    testl   %eax, %eax
    jnz  .L43
    jmp .L44
.L43:
    leal    -8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    12(%ebx), %eax
    pushl   %eax
    pushl   12(%ebp)
    pushl   -16(%ebp)
    pushl   $2
    popl    %ebx
    popl    %eax
    movl    %eax, %edx
    sar    $31, %edx
    idiv    %ebx
    pushl   %eax
    popl    %eax
    popl    %ebx
    subl    %eax, %ebx
    pushl   %ebx
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    jmp .L45
.L44:
    leal    -8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    12(%ebx), %eax
    pushl   %eax
    pushl   -16(%ebp)
    pushl   $13
    popl    %ebx
    popl    %eax
    movl    %eax, %edx
    sar    $31, %edx
    idiv    %ebx
    pushl   %edx
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
.L45:
    leal    -8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    4(%ebx), %eax
    pushl   %eax
    pushl   -12(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    pushl   8(%ebp)
    popl    %eax
    testl   %eax, %eax
    jnz  .L48
    jmp .L49
.L48:
    leal    -8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    12(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    call    printInt
    popl    %ebx
.L49:
    leal    -16(%ebp), %eax
    pushl   %eax
    popl    %eax
    incl    (%eax)
    jmp .L38
.L40:
    leal    -8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    8(%ebx), %eax
    pushl   %eax
    pushl   $0
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    pushl   8(%ebp)
    popl    %eax
    testl   %eax, %eax
    jnz  .L50
    jmp .L51
.L50:
    pushl   $.LC1
    call    printString
    popl    %ebx
.L51:
    pushl   8(%ebp)
    popl    %eax
    testl   %eax, %eax
    jnz  .L52
    jmp .L53
.L52:
    pushl   12(%ebp)
    call    printInt
    popl    %ebx
.L53:
    pushl   8(%ebp)
    popl    %eax
    testl   %eax, %eax
    jnz  .L54
    jmp .L55
.L54:
    pushl   $.LC2
    call    printString
    popl    %ebx
.L55:
    pushl   -4(%ebp)
    popl    %eax
    leave
    ret
przejdzSieNaKoniecIWypisuj:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $12, %esp
    pushl   12(%ebp)
    popl    -4(%ebp)
    pushl   12(%ebp)
    popl    -8(%ebp)
    pushl   $.LC3
    call    printString
    popl    %ebx
    pushl   $0
    popl    -12(%ebp)
.L56:
    pushl   -12(%ebp)
    pushl   8(%ebp)
    popl    %eax
    cmpl    %eax, 0(%esp)
    jge .L59
    pushl   $1
    jmp .L60
.L59:
    pushl   $0
.L60:
    popl    %eax
    testl   %eax, %eax
    jnz  .L57
    jmp .L58
.L57:
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    12(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    call    printInt
    popl    %ebx
    leal    -8(%ebp), %eax
    pushl   %eax
    pushl   -4(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -4(%ebp), %eax
    pushl   %eax
    leal    -4(%ebp), %eax
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
    leal    -12(%ebp), %eax
    pushl   %eax
    popl    %eax
    incl    (%eax)
    jmp .L56
.L58:
    pushl   -8(%ebp)
    popl    %eax
    leave
    ret

