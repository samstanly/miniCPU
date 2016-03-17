	addi $sp, $0, 0x3ffc
	addi $s0, $0, 0x10
	addiu $s1, $0, 0x3000
	sw $s0, 0($s1)
	addi $s0, $0, 0xf
	sw $s0, 4($s1)
	lw $s2, 0($s1)
	lw $s2, 4($s1)
