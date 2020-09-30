.data
	
.text
.include "messaggi.asm"
.globl main

main:
checkDim:
	li $v0,4
	la $a0,msg
	syscall
	
	li $v0,5 
	syscall #chiedo dim
	
	bgt  $v0,$zero,dimOk #controllo dim
		li $v0,4
		la $a0,errore
		syscall
	j checkDim
			
dimOk:
	move $a0,$v0
	jal allocaArray
	
	li $v0,4
	la $a0,msg2
	syscall
	
	jal carica
loopMenu:
	li $v0,4
	la $a0,menu
	syscall
	
	li $v0,5
	syscall
	
	
	bne $v0,1,case2
		li $v0,4
		la $a0,msg2
		syscall
		
		jal carica #case1
		j fineSwitch
case2:
	bne $v0,2,case3
		jal ordinaCrescente #case2
		li $v0,4
		la $a0,msg3
		syscall
		jal stampaArray
		j fineSwitch
case3: 
	bne $v0,3,case4
		jal ordinaDecrescente #case3
		li $v0,4
		la $a0,msg3
		syscall
		jal stampaArray
		j fineSwitch
case4: 
	bne $v0,4,case0
		jal stampaArray #case4
		j fineSwitch
case0:
	bnez $v0 ,error #exit
		j end

error:
	li $v0,4
	la $a0,errore
	syscall
	
fineSwitch:
j loopMenu
end:

li $v0,10
syscall