
.globl main

prng: 
	li $t1,1083814273 # =>(42 * 1664525 + 1013904223) % 2**32
	div $t1 ,$t0
	mfhi $t2
	jr $ra
jeu : 
	li $v0,4
	la $a0, jeuword
	syscall
	 
	move $t3,$t2
	li $t4,-1
	while:
	li $v0,4
	la $a0,guess 
	syscall
	li $v0,5
	syscall
	move $t4,$v0
	beq $t4,$t3,end_while 
	bgt $t4,$t3,print_sup
	li $v0,4
	la $a0,petit 
	syscall
	b while 
	
 print_sup :
	 li $v0,4
	 la $a0,grand 
	 syscall
	 b while
 end_while:
	 li $v0,4
	 la $a0,bravo
	 syscall
	 jr $ra

main:
	li $t0,300
	jal prng
	jal jeu 
	li $v0,10
	syscall 
	jr $ra
	
.data 
nl : .asciiz "\n"
jeuword : .asciiz "le nombre est entre 0 et 300 \n" 
bravo : .asciiz "Bravo :) \n"
grand: .asciiz "trop grand \n"
petit: .asciiz "trop petit \n"
guess : .asciiz "Entrez un nombre : "
