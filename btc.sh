#!/bin/sh


i=0
clear
while [ 1 ]; do

	#get folder name
	SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

	#each 10th iteration, it prints to the file indicated by $1
	if [ "$i" -eq "999" ]; then
		sh $SCRIPT_DIR/btscript2.sh | tee -a $1
		i=0
	else
		sh $SCRIPT_DIR/btscript2.sh
	fi

	#Move the cursor up 42 lines:
 	printf "\033[42A"

 	i=$(($i+1))

 	# sleep 
done




