	addi $sp, $0, 0x3ffc
	addi $s0, $0, 0x10
	slti, $s1, $s0, 0x8 #false
	slti, $s1, $s0, 0x12 #true
	addi $s0, $0, -32768 
	addiu $s1, $0, 0
	slti $s1, $s0, 0x7fff #true
	sltiu $s1, $s0, 0x7fff #false
