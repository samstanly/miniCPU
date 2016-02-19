p1:
	cp alu.circ tests
	cp regfile.circ tests
	cd tests && python ./sanity_test.py > ../TEST_LOG
