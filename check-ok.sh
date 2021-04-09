#!/bin/bash
#set -x

for entry in "$1"/*
	do
		cat $entry | grep -q "csrw"
		if [ $? -eq 0 ]
		then
			#echo $?
			echo "[OK]" $'\t' $entry
		else
			echo "[ERR]" $'\t' $entry
			filename="${entry##*/}"
			filename="../riscv-benchmark/results/${filename%-hist.txt}" 
			echo "Running" $filename
			./count-single.sh $filename
			sleep 2
		fi
	done
