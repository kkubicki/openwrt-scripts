#!/bin/sh
tries=0
while [[ $tries -lt 5 ]]
do
	if /bin/ping -c1 -w5 8.8.8.8 > /dev/null
	then
		exit 0
	fi
	tries=$((tries+1))
done
date >> /mnt/share/restarts.txt
sleep 70 && touch /etc/banner && reboot