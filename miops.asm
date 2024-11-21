.data
 matriz1: .word 1, 2, 3, 4
          .word 5, 6, 7, 8
          .word 9, 10, 11, 12
          .word 13, 14, 15, 16

 matriz2: .word 1, 1, 1, 1
          .word 1, 1, 1, 1
          .word 1, 1, 1, 1
          .word 1, 1, 1, 1
           
.text
 miops:
	la $a1, matriz1
	la $a2, matriz2
	li $t7, 4

	sub $sp, $sp, $t0 # liberando o espaço pra matriz resultado
	move $s0, $sp
	
	li $t1, 0 # i = 0 
  for_i:
	beq $t1, $t7, end_i
	
	li $t2, 0 # j = 0
    for_j:
	beq $t2, $t7, end_j
	
	li $t0, 0 # aux = 0
	li $t3, 0 # k = 0
      for_k:
	beq $t3, $t7, end_k
	
	sll $t4, $t1, 2
	add $t4, $t4, $t3
	sll $t4, $t4, 2
	add $t4, $t4, $a1
	
	sll $t5, $t3, 2
	add $t5, $t5, $t2
	sll $t5, $t5, 2
	add $t5, $t5, $a2
	
	lw $s1, 0($t4) # matriz1 [i][k]
	lw $s2, 0($t5) # matriz2 [k][j]
	
	mul $s3, $s1, $s2 # matriz1 [i][k] * matriz2 [k][j]
	add $t0, $t0, $s3
	
	addi $t3, $t3, 1 # k = k+1
	j for_k
      end_k:
      
	sll $t6, $t1, 2
	add $t6, $t6, $t2 
	sll $t6, $t6, 2
	add $t6, $t6, $s0
	sw $t0, 0($t6) # matriz3 [i][j]
      
        li $v0, 1 # imprimir o resultado
        move $a0, $t0
        syscall

        li $v0, 11 # imprimir espaço
        li $a0, 32
        syscall
      
	addi $t2, $t2, 1 # j = j+1
	j for_j
    end_j:
    
        li $v0, 11 # imprimir nova linha
        li $a0, 10
        syscall
    
    	addi $t1, $t1, 1 # i = i+1
    	j for_i
  end_i:
  	
  	li $v0, 10
  	syscall
