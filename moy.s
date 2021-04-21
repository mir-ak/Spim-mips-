.text
.globl main

calc_moy:
 		li $t0, 0                   #n=0
    li $t2, 0                   #moy=0
    j while              
    
while:
  beq $t3, 1, end_while         
  addi $s0, $s0, -4           
  lw $t1, 0($s0)              
  add $t3, $t3, -1            
  add $t2, $t2, $t1           #moy+=note
  add $t0, $t0, 1             #n+=1
  j while                 
  
end_while:
	  div $t2, $t2, $t0           
	  move $a0, $t2               
	  li $v0, 1                   
	  syscall    
	  
	  li $v0, 4
	  la $a0, nl                  
	  syscall 
	                        
	  li $v0, 10                  
	  syscall                     

while_true:
    li $v0, 4
    la $a0, note                
    syscall                    
    
    move $a0, $t0
    li $v0, 1                   
    syscall                     
    
    li $v0, 4 
    la $a0, twop               
    syscall                     
    
    li $v0, 4
    la $a0, space               
    syscall                     
    
    li $v0, 5
    syscall                    
    move $t1, $v0               
    
    beq $t1, -1, exit             
    b end_while_true           

exit: 
		li $v0, 4
    la $a0, moy                 
    syscall    
    jal calc_moy        
    li $v0, 10                  
		syscall        

end_while_true:
    li $v0, 9                   
    li $a0, 4                   
    syscall
    move $s0, $v0                   
    sw $t1, 0($s0)              
    addi $s0, $s0, 4            
        
    add $t0, $t0, 1             
    move $t3, $t0               
    
    b while_true                 

main:
    li $v0, 4
    la $a0, info
    syscall                     
    li $t0, 1                   
    jal while_true               
                    
            

.data
info: .asciiz "Entrez vos notes, en finissant par -1:\n"
note: .asciiz "Note "
moy: .asciiz "Votre moyenne est "
twop : .asciiz ":"
space : .asciiz " "
nl: .asciiz "\n"
