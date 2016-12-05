#!/bin/bash

sites=$1
count=0
for i in $(echo $sites | sed "s/,/ /g")
do
	response=$(curl $i -s -f -L --connect-timeout 10)
	metatag=$(grep 'name="viewport"' <<< "$response")
	(( count++ ))
	if [[ $metatag ]]; then
		echo "responsive - $count"
	else
	   	metatag=$(grep "name='viewport'" <<< "$response")
		if [[ $metatag ]]; then
		    echo "responsive - $count"
		else
		    echo "not-responsive - $count"
		fi
	fi
done