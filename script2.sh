#/bin/bash
TEST_FILES="tests/student/*.s"
if [ -n "$1" ]; then
 TEST_FILES="tests/student/$1.s"
fi 
CIRC='tests/CPU-tester.circ'
LOG='tests/logisim.jar'
MARS='tests/Mars4_5.jar'
TOTAL_CASE=0
PASS_CASE=0
for INPUT in $TEST_FILES
do
	pass=1;
	BASE=${INPUT%.*};
	OUTPUT="$BASE.out";
	OUTPUT2="$BASE.out2";
	HEX="$BASE.hex";
	echo "Assembling $INPUT..."
	python2.7 assembler.py $INPUT;
	if [ ! -f "$HEX" ]; then exit 1; fi
	INST=`cat "$HEX" | perl -pe 's/v2.0 raw\n//g' | perl -pe 's/\n/ /g'`;
	INST_COUNT=`tr -cd "\n" < "$HEX" | wc -c | perl -pe 's/[^[0-9]]*//g'`;
	INST_COUNT=`printf "%x" $INST_COUNT`;

	cat "$CIRC" | perl -pe 's/\n/<NEWLINE>/g' | perl -pe "s/<a name=\"contents\">addr\/data: 24 32.*<\/a>/<a name=\"contents\">addr\/data: 24 32<NEWLINE>$INST<NEWLINE><\/a>/g" | perl -pe 's/<NEWLINE>/\n/g' > "$CIRC.tmp" ;
	mv "$CIRC.tmp" "$CIRC";
	rm "$HEX";

	echo "Running $INPUT...";
	java -jar $LOG -tty table $CIRC | python "tests/decode_out.py" cpu | tail -n1 | cut -f1-5 > "$OUTPUT";
	java -jar $MARS nc mc CompactTextAtZero s0 s1 s2 ra sp $INPUT | sed 1d | cut -f2| perl -pe 's/0x//'| perl -pe 's/\n/\t/g' | rev | perl -pe 's/\t//' | rev > "$OUTPUT2";
	RESULT=`cat $OUTPUT`;
	MARS_RES=`cat $OUTPUT2`;
	echo $MARS_RES > "$OUTPUT2";
	# printf "Expected:\n$MARS_RES\n";
	# printf "Recieved:\n$RESULT\n";
    	compare=`diff -b $OUTPUT $OUTPUT2`;
    	if [ -n "$compare" ]; then
       	 	echo "[Difference in output]";
       	 	echo "$compare";
        	pass=0;
    	fi
    	if [ $pass -eq 1 ]; then
        	echo " - Test Passed";
        	PASS_CASE=$(($PASS_CASE+1));
    	fi
    	TOTAL_CASE=$((TOTAL_CASE+1));
	rm "$OUTPUT2";
	rm "$OUTPUT";
done
echo "--------------------------------"
echo "(PASSED: $PASS_CASE/$TOTAL_CASE)"
echo ""