#!/bin/bash

EXPECTED=$1
OUTPUT=$2

while read LINE
do
	git clone https://github.com/CSE2307SP26/$LINE.git
	cd $LINE
	git checkout cipher
	git checkout `git rev-list -n 1 --first-parent --before="2026-02-12 10:00" cipher`
	javac Cipher.java
	java Cipher
	if [ -f $OUTPUT ]; then
		if [[ "$(cat $OUTPUT)" == "$(cat ../$EXPECTED)" ]]
		then
			echo "$LINE : 1"
		else
			echo "$LINE : 0"
		fi
	else
		echo "$LINE : 0"
	fi
	cd ..

done
