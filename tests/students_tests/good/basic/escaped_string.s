.globl main

.LC0:
.string "\"\npop\npowrot:\ngetstatic java/lang/System/out Ljava/io/PrintStream;\nldc \"zle \"\ninvokevirtual java/io/PrintStream/print(Ljava/lang/String;)V\ngoto powrot\nldc \""

f:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $4, %esp
    pushl   8(%ebp)
    pushl   $2
    pushl   8(%ebp)
    popl    %eax
    popl    %ebx
    imul    %ebx, %eax
    pushl   %eax
    popl    %eax
    popl    %ebx
    addl    %ebx, %eax
    pushl   %eax
    popl    -4(%ebp)
    pushl   $.LC0
    call    printString
    popl    %ebx
    pushl   -4(%ebp)
    popl    %eax
    leave
    ret
main:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $0, %esp
    pushl   $1
    call    f
    popl    %ebx
    pushl   %eax
    pushl   $3
    popl    %eax
    popl    %ebx
    subl    %eax, %ebx
    pushl   %ebx
    popl    %eax
    leave
    ret
