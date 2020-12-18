#!/bin/sh
if ping -q -c 2 -W 10 8.8.8.8 > /dev/null; then
	exit 0
fi
sleep 70
if ping -q -c 2 -W 10 8.8.8.8 > /dev/null; then
	exit 0
fi
touch /etc/banner
iftop -iwlan0 -t -s 10 -L 10 > "/mnt/share/restart_$(date +%Y_%m_%d_%H_%M).log"
/etc/init.d/vnstat_backup backup
#echo -e 'AT^RESET\r' > /dev/ttyUSB2 
#sleep 1
sync
reboot
