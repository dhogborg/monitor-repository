#!/bin/bash

cd /home/

# list all inputs | dont include archive | replace ./ with nuthin'
inputs=`find . -maxdepth 1 -type d  | grep -v archive | sed 's/\.\///'`

day=`date +%u`

rm -r ~/archive/$day

for input in inputs
do
	mv /home/@input /home/archive/$day
	mkdir -p /home/@input
done

touch ~/archive/last_rotation