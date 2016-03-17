addi $sp, $0, 0x3ffc
start:
	jal addition
	j end
	addi $s2, $0, 99
addition:
	addi $s0 $0, 5
	jr $ra
	addi $s0, $0, 99
	j start
end:
	

