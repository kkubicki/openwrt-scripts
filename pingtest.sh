#!/bin/sh
if ping -q -c 2 -W 10 8.8.8.8 > /dev/null; then
	exit 0
fi

logFileName="/tmp/`date +%Y_%m_%d_%H_%M`"
logFileNameGZ="$logFileName.gz"
top -n1 -b | head >> $logFileName
dmesg | tail >> $logFileName
logread | tail >> $logFileName
iftop -iwlan0 -t -s 10 -L 5 >> $logFileName
gzip $logFileName
mv $logFileNameGZ /mnt/share/

/etc/init.d/vnstat_backup backup
sleep 70

if ping -q -c 2 -W 10 8.8.8.8 > /dev/null; then
	exit 0
fi

touch /etc/banner
echo -e 'AT^RESET\r' > /dev/ttyUSB2
sleep 1
reboot
