#!/bin/bash

cron

archive="/home/ftpusers/archive"

# Bootstrap the archive
if [ ! -e $archive ]; then 
	
	/usr/sbin/pure-ftpd \
		--createhomedir \
		--login puredb:/etc/pure-ftpd/pureftpd.pdb &

	if [ ! $ADMIN_PASSWORD ]; then
		ADMIN_PASSWORD=`date +%s | sha256sum | base64 | head -c 32`
	fi

	echo $ADMIN_PASSWORD > /tmp/pw
	echo $ADMIN_PASSWORD >> /tmp/pw
	echo "" >> /tmp/pw
	
	mkdir -p $archive
	cd $archive
	mkdir 1 2 3 4 5 6 7

	pure-pw useradd admin -u ftpuser -d /home/ftpusers/ < /tmp/pw;
	pure-pw mkdb

	echo "++++++++++++++++++++"
	echo -n "Admin password: "
	echo $ADMIN_PASSWORD
	echo ""

	rm /tmp/pw
	kill $(cat /var/run/pure-ftpd.pid)
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
