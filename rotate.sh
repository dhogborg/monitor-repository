#!/bin/bash

cd /home/ftpusers
archive="/home/ftpusers/archive"

# list all inputs | don't include archive | replace ./ with nuthin'
inputs=`find . -maxdepth 1 -type d  | grep -v archive | sed 's/\.\///'`

day=`date +%u`

# remove last weeks archive for this day
rm -r $archive/$day
mkdir $archive/$day
# iterate over each camera 
for input in $inputs
do
	if [ $input != "." ]; then
	    # move it to the archive day, retain the name
	    mv /home/ftpusers/$input $archive/$day/

	    # pure-ftpd will re-create the home dir on next login by client
	fi
done

# set a new timestamp 
echo `date` > $archive/last_rotation

