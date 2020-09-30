.data
	dim: .word 0 
	address: .word 0
.text

.globl allocaArray
.globl carica
.globl stampaArray
.globl ordinaCrescente
.globl ordinaDecrescente

allocaArray: # a0 = dim
	#salvo in stack 
	addi $sp,$sp,-4
	sw $ra,0($sp)
	

	la $t0,dim
	sw $a0,0($t0)
	
	mul $a0,$a0,4 #byte da allocare
	li $v0,9
	syscall
	
	la $t1,address
	sw $v0,0($t1)
	
	
	#ripristino reg
	lw $ra,0($sp)
	addi $sp,$sp,4
	
	
	jr $ra
	
	
# fine alloca

carica:
	#salvo in stack 
	addi $sp,$sp,-4
	sw $ra,0($sp)
	
	la $t1,dim
	lw $t0,0($t1) #t0 = dim
	
	la $t1,address #indirizzo vettore
	move $t2,$zero #i 
	move $t3,$zero #indirizzo elemento
loopCarica:
	beq $t2,$t0 fineloopCarica
	
	mul $t4,$t2,4 #offset
	add $t3,$t4,$t1 #indirizzo 
	
	li $v0,5
	syscall
	
	sw $v0,0($t3)
	addi $t2,$t2,1
	j loopCarica
	
fineloopCarica:
	#ripristino reg
	lw $ra,0($sp)
	addi $sp,$sp,4
	
	jr $ra

#fine carica

stampaArray:
	#salvo in stack 
	addi $sp,$sp,-4
	sw $ra,0($sp)
	
	la $t1,dim
	lw $t0,0($t1) #t0 = dim
	
	la $t1,address #indirizzo vettore
	move $t2,$zero #i 
	move $t3,$zero #indirizzo elemento
loopStampa:
	beq $t2,$t0 fineloopStampa
	
	mul $t4,$t2,4 #offset
	add $t3,$t4,$t1 #indirizzo 
	
	lw $a0,0($t3)
	li $v0,1
	syscall
	
	li $a0,' '
	li $v0,11
	syscall
	
	
	addi $t2,$t2,1
	j loopStampa
	
fineloopStampa:
	#ripristino reg
	lw $ra,0($sp)
	addi $sp,$sp,4
	
	jr $ra

#fine stampaArray

ordinaCrescente:

	#salvo in stack 
	addi $sp,$sp,-4
	sw $ra,0($sp)
	
	la $t0,dim
	lw $t0,0($t0) # dim
	
	
	addi $t1,$t0,-1 #dim-1
	
	la $t2,address
	move $t3,$zero #i
	
loopCi:
	beq $t1,$t3 fineloopCi #dim -1 = i?
	
	addi $t4,$t3,1 # j = i+1
	loopCj:
		beq $t0,$t4 fineloopCj #dim = j?
		
		addi $sp,$sp,-8
		sw $t3,0($sp) #sevono t3 e t4 per a[i] e a[j]
		sw $t4,4($sp)
		
			mul $t5,$t3,4
			add $t5,$t5,$t2 # indirizzo a[i]
			lw $t3,0($t5) #a[i]
			
			mul $t6,$t4,4
			add $t6,$t6,$t2 # indirizzo a[j]				
			lw $t4,0($t6) #a[j]
			
			blt $t3,$t4 oltreC #t3 < #t4
				sw $t3,0($t6)
				sw $t4,0($t5)
		oltreC:
			lw $t4,4($sp)
			lw $t3,0($sp)
			addi $sp,$sp,8 
		
		addi $t4,$t4,1
		j loopCj	
	fineloopCj:	
	
	addi $t3,$t3,1
	j loopCi
	
fineloopCi:

#ripristino reg
	lw $ra,0($sp)
	addi $sp,$sp,4
	
	jr $ra
#fine OrdinaCrescente


ordinaDecrescente:

	#salvo in stack 
	addi $sp,$sp,-4
	sw $ra,0($sp)
	
	la $t0,dim
	lw $t0,0($t0) # dim
	
	
	addi $t1,$t0,-1 #dim-1
	
	la $t2,address
	move $t3,$zero #i
	
loopDi:
	beq $t1,$t3 fineloopDi #dim -1 = i?
	
	addi $t4,$t3,1 # j = i+1
	loopDj:
		beq $t0,$t4 fineloopDj #dim = j?
		
		addi $sp,$sp,-8
		sw $t3,0($sp) #sevono t3 e t4 per a[i] e a[j]
		sw $t4,4($sp)
		
			mul $t5,$t3,4
			add $t5,$t5,$t2 # indirizzo a[i]
			lw $t3,0($t5) #a[i]
			
			mul $t6,$t4,4
			add $t6,$t6,$t2 # indirizzo a[j]				
			lw $t4,0($t6) #a[j]
			
			bgt $t3,$t4 oltreD #t3 > #t4
				sw $t3,0($t6)
				sw $t4,0($t5)
		oltreD:
			lw $t4,4($sp)
			lw $t3,0($sp)
			addi $sp,$sp,8 
		
		addi $t4,$t4,1
		j loopDj	
	fineloopDj:	
	
	addi $t3,$t3,1
	j loopDi
	
fineloopDi:

#ripristino reg
	lw $ra,0($sp)
	addi $sp,$sp,4
	
	jr $ra
#fine OrdinaDecrescente



