p1:
	cp alu.circ regfile.circ tests
	cd tests && python ./sanity_test.py | tee ../TEST_LOG
