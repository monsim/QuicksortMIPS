.text
#-------------------------------------------
# Procedure: insertion_sort
# Argument: 
#	$a0: Base address of the array
#       $a1: Number of array element
# Return:
#       None
# Notes: Implement insertion sort, base array 
#        at $a0 will be sorted after the routine
#	 is done.
#-------------------------------------------
insertion_sort:
	# Caller RTE store (TBD)
	addi	$sp, $sp, -40
	sw	$fp, 40($sp)
	sw	$ra, 36($sp)
	sw	$a0, 32($sp)
	sw	$a1, 28($sp)
	sw	$a2, 24($sp)
	sw	$a3, 20($sp)
	sw	$s0, 16($sp)
	sw	$s1, 12($sp)
	sw	$s2, 8($sp)
	addi	$fp, $sp, 40
	
	
	li 	$s2, 1	
	
	#a1 is the length, s2 is i (starts at 1), s3 is j, s4 is a[j], s5 is a[j-1]
	#a2 is going to be low, $a3 is high
	# Implement insertion sort (TBD)
	li $a2, 0 
	addi $a3, $a1, -1
L1:	
	bge $a2, $a3, quick_sort_end #if low < high
	jal partition   #pi is sotred in $t1
	move $t2, $a3	#t2 is now high
	addi $t3, $t1, -1   #t3 = pi - 1
	move $a3, $t3
	jal L1
	addi $t3, $t1, 1	#t3 = pi + 1
	move $t4, $a2 	#t4 is now low
	move $a2, $t3 	#a2 is pi + 1
	move $a3, $t2	#restore high from t2
	jal L1
	 
partition: 
	sll $t5,$a3,2 # $t5 = 4*i
	add $t6,$a0,$t5 # add offset to the address of A[0]
	# now $t6 = address of A[i]
	lw $t7,0($t6) # $t7 = whatever is in A[i] PIVOT	
	addi $t3, $a2, -1  #i = low - 1	
	move $t4, $a2	# j = low
	
LOOP:
	bge $t4, $a3, END_LOOP	#t4 = j
	# if (arr[j] <= pivot). branch is greater than INC
	# ...
	
	# s0 = arr[j] 
	sll $t5,$t4,2 # $t5 = 4*j
	add $t6,$a0,$t5 # add offset to the address of A[0]
	lw $s0,0($t6) 
	
	ble $s0, $t7, INSIDE_IF  #if arr[j] <= pivot 
	
	j INC


INSIDE_IF:
	addi $t3, $t3, 1 #i++
	
	
	#swap arr[i] and arr[j]
	
	# s1 = arr[i] 
	sll $t5,$t3,2 # $t5 = 4*i
	add $t6,$a0,$t5 # add offset to the address of A[0]
	lw $s1,0($t6) 
	
	#arr[i] = arr[j]
	sll $t5,$t3,2 # $t5 = 4*i
	add $t6,$a0,$t5 # add offset to the address of A[0]
	sw $s0,0($t6)  
	
	#arr[j] = OLD arr[i] (
	sll $t5,$t4,2 # $t5 = 4*j   **CHECK 
	add $t6,$a0,$t5 # add offset to the address of A[0]
	sw $s1,0($t6)  
	j INC					

INC:
	addi $t4, $t4, 1 #increment j
	j LOOP


END_LOOP:
	# swap arr[i + 1] and arr[high])
	
	# s1 = arr[i+1] 
	addi $t6, $t3, 1 #t6 = i + 1
	sll $t5,$t6,2 # $t5 = 4*(i+1)
	add $t6,$a0,$t5 # add offset to the address of A[0]
	lw $s1,0($t6)
	
	# s2 = arr[high]
	sll $t5,$a3,2 # $t5 = 4*high
	add $t6,$a0,$t5 # add offset to the address of A[0]
	lw $s2,0($t6)
	
	# arr[i+1] = arr[high]
	addi $t6, $t3, 1 #t6 = i + 1
	sll $t5,$t6,2 # $t5 = 4*(i+1)
	add $t6,$a0,$t5 # add offset to the address of A[0]
	sw $s2,0($t6)
	
	# arr[high] = old arr[i+1]
	sll $t5,$a3,2 # $t5 = 4*(i+1)
	add $t6,$a0,$t5 # add offset to the address of A[0]
	sw $s1,0($t6)
	
	addi $t1, $t3, 1 # set pi to (i + 1). $t1 = i+1s
    	
    	jr $ra	#go back to where partition was called 
				
														
quick_sort_end:
	# Caller RTE restore (TBD)
	lw	$fp, 40($sp)
	lw	$ra, 36($sp)
	lw	$a0, 32($sp)
	lw	$a1, 28($sp)
	lw	$a2, 24($sp)
	lw	$a3, 20($sp)
	lw	$s0, 16($sp)
	lw	$s1, 12($sp)
	lw	$s2, 8($sp)
	addi	$sp, $sp, 40
	# Return to Caller
	jr	$ra
