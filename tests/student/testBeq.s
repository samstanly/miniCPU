addi $sp, $0, 0x3ffc
addi $s0, $0, 0x10
andi $s1, $s0, 0x2
start:
	bne $s0, $s1, skip
	beq $s1, $s0, start
skip:
	addi $s0, $0, 0x2
	beq $s0, $s1, end
	addi $s0, $0, 0x999
end: