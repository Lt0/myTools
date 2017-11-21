#!/bin/bash 
S_IP=172.2.11.91
TIMES=3
TIME=10
SCALE=2

SEP="========================"
F_NUM=num.output
F_TMP=tmp.output

clear_tmp(){
	rm $F_NUM $F_TMP 2>/dev/null
}


run_test(){
	for ((i=0; i<$TIMES; i+=1))
	do
		iperf -c $S_IP -t $TIME | tee $F_TMP
		cat $F_TMP | grep "bits/sec" | sed 's/^.*Bytes  //g' | sed 's/ .*bits\/sec//g' >> $F_NUM
		printf "\n\n"
	done
}

count_time(){
	TOTAL_TIME=0
	for num in $(cat $F_NUM)
	do
		TOTAL_TIME=$(echo "$TOTAL_TIME+$num" | bc)
	done
}


report(){
	echo $SEP Stop at $(date) $SEP
	echo Min: $(cat $F_NUM | sort | head -n1) Gbits/sec
	echo Max: $(cat $F_NUM | sort | tail -n1) Gbits/sec
	echo Average: $(echo "scale=$SCALE; $TOTAL_TIME/$TIMES" | bc) Gbits/sec
	echo Average: $(echo "scale=$SCALE; $TOTAL_TIME/$TIMES/8" | bc) Gbytes/sec
	echo Times: $TIMES
	echo Time Per Test: $TIME seconds
	echo Total Time: $TOTAL_TIME seconds
	echo
}

run(){
	echo $SEP Start at $(date) $SEP
	clear_tmp
	run_test
	count_time
	report
	clear_tmp
}

run

