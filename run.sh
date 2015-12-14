#!/bin/bash

cron

# Bootstrap the archive
if [ ! -e /home/archive ]; then 
	
	if [ ! $ADMIN_PASSWORD ]; then
		ADMIN_PASSWORD=`date +%s | sha256sum | base64 | head -c 32`
	fi

	echo $ADMIN_PASSWORD > /tmp/pw
	echo $ADMIN_PASSWORD >> /tmp/pw
	echo "" >> /tmp/pw
	
	archive="/home/archive"
	mkdir -p $archive
	cd $archive
	mkdir 0 1 2 3 4 5 6 

	pure-pw useradd $1 -u ftpuser -D /home/ < /tmp/pw;
	pure-pw mkdb

	echo "++++++++++++++++++++"
	echo -n "Admin password: "
	echo $ADMIN_PASSWORD
	echo ""

	rm /tmp/pw
fi

/usr/sbin/pure-ftpd \
	--maxclientsnumber 50 \
	--maxclientsperip 10 \
	--login puredb:/etc/pure-ftpd/pureftpd.pdb \
	--noanonymous \
	--createhomedir \
	--nochmod \
	--forcepassiveip $PUBLICHOST \
	--passiveportrange 30000:30009
