.text
.globl main

main:
    li $t0, 1
    li $t2, 2147483647
    while:
        sltu $t3, $t2, $t0
        bgt $t3, $t0, exit

        move $t1, $t0
        
        while_2:
            blez $t1, print_shift 
            and $t5, $t1, 1 
            beq $t5, $0, print_space

            li $v0, 4
            la $a0, hashtag
            syscall
            j else

            print_space:
                li $v0, 4
                la $a0, space
                syscall

            else:
                sra $t1, $t1,1
                b while_2

	print_shift:
            li $v0, 4
            la $a0, nl
            syscall

            move $t4, $t0 
            sll $t4, $t4, 1
            xor $t0, $t0, $t4 
            b while

    exit:
 	li $v0, 10
	syscall
	jr $ra

.data
hashtag:  .asciiz "#"
space:  .asciiz " "
nl:    .asciiz "\n"
