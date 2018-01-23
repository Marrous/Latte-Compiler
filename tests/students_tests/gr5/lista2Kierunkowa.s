.globl main

.LC0:
.string "po spacerku wartosc pierwszego elementu:"
.LC1:
.string "po spacerku wartosc drugiego elementu:"
.LC2:
.string "idziemy na koniec listy: "
.LC3:
.string "wracamy na poczatek listy: "
.LC4:
.string "Krotki test listy:"
.LC5:
.string "wygenerowal liste 2kierunkowa dlugosci :"
.LC6:
.string "__________"

main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $4, %esp
    pushl   $30
    popl    -4(%ebp)
    pushl   -4(%ebp)
    call    listaTest
    popl    %ebx
    pushl   $0
    popl    %eax
    leave
    ret
listaTest:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $8, %esp
    pushl   $30
    pushl   8(%ebp)
    call    zwrocListeDlugosci
    popl    %ebx
    pushl   %eax
    popl    -4(%ebp)
    pushl   -4(%ebp)
    pushl   8(%ebp)
    call    przejdzSieNaKoniecIWypisuj
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    -8(%ebp)
    leal    -4(%ebp), %eax
    pushl   %eax
    pushl   -8(%ebp)
    pushl   8(%ebp)
    call    wrocNaPoczatekIWypisuj
    popl    %ebx
    popl    %ebx
    pushl   %eax
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    pushl   $.LC0
    call    printString
    popl    %ebx
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
    pushl   8(%ebp)
    pushl   $5
    popl    %eax
    cmpl    %eax, 0(%esp)
    jl  .L3
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
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    8(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    popl    -12(%ebp)
    pushl   $.LC1
    call    printString
    popl    %ebx
    leal    -4(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    8(%ebx), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    12(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    call    printInt
    popl    %ebx
    jmp .L2
.L1:
    leave
    ret
.L2:
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
    pushl   $.LC2
    call    printString
    popl    %ebx
    pushl   $0
    popl    -12(%ebp)
.L5:
    pushl   -12(%ebp)
    pushl   8(%ebp)
    popl    %eax
    cmpl    %eax, 0(%esp)
    jge .L8
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
    jmp .L5
.L7:
    pushl   -8(%ebp)
    popl    %eax
    leave
    ret
wrocNaPoczatekIWypisuj:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $12, %esp
    pushl   12(%ebp)
    popl    -4(%ebp)
    pushl   $0
    popl    -8(%ebp)
    pushl   $.LC3
    call    printString
    popl    %ebx
    pushl   8(%ebp)
    popl    -12(%ebp)
.L10:
    pushl   -12(%ebp)
    pushl   $0
    popl    %eax
    cmpl    %eax, 0(%esp)
    jle .L13
    pushl   $1
    jmp .L14
.L13:
    pushl   $0
.L14:
    popl    %eax
    testl   %eax, %eax
    jnz  .L11
    jmp .L12
.L11:
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
    leal    4(%ebx), %eax
    pushl   %eax
    popl    %eax
    pushl   (%eax)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
    leal    -12(%ebp), %eax
    pushl   %eax
    popl    %eax
    decl    (%eax)
    jmp .L10
.L12:
    pushl   -8(%ebp)
    popl    %eax
    leave
    ret
zwrocListeDlugosci:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp
    pushl   $.LC4
    call    printString
    popl    %ebx
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
.L15:
    pushl   -16(%ebp)
    pushl   8(%ebp)
    popl    %eax
    cmpl    %eax, 0(%esp)
    je  .L18
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
    leal    -8(%ebp), %eax
    pushl   %eax
    popl    %eax
    movl    (%eax), %ebx
    leal    12(%ebx), %eax
    pushl   %eax
    pushl   -16(%ebp)
    popl    %eax
    popl    %ebx
    movl    %eax, (%ebx)
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
    leal    -16(%ebp), %eax
    pushl   %eax
    popl    %eax
    incl    (%eax)
    jmp .L15
.L17:
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
    pushl   $.LC5
    call    printString
    popl    %ebx
    pushl   8(%ebp)
    call    printInt
    popl    %ebx
    pushl   $.LC6
    call    printString
    popl    %ebx
    pushl   -4(%ebp)
    popl    %eax
    leave
    ret
