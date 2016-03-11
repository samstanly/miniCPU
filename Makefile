p1:
	cp alu.circ regfile.circ tests
	cd tests && python2.7 ./sanity_test.py | tee ../TEST_LOG
