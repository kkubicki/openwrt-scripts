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
/etc/init.d/vnstat_backup backup && sleep 1 && umount /mnt/share/

r=$((0x$(cut -c1-1 /proc/sys/kernel/random/uuid) % 2))
if [ $r -eq 1 ]; then
 sleep 70 && touch /etc/banner && reboot
else
 sleep 5 && echo -e 'AT^RESET\r' > /dev/ttyUSB2
fi
