addi $sp, $0, 0x3ffc
addi $s1, $0, 5
start:
	jal incr
	j end
	addi $s2, $0, 99
incr:
loop:
	beq $s0, $s1, endfunc
	addi $s0 $s0, 1
	j loop
endfunc:
	jr $ra
	addi $s0, $0, 99
	j start
end:
	

