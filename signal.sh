#! /bin/ash
ifaces="wlan0"

for iface in $ifaces
do
  echo $iface
  stations=`iw dev $iface station dump | grep Station | awk '{print $2}'`

  for sta in $stations
  do
    echo "------------------------------------------------------"
    iw dev $iface station get $sta
    echo -e "\t ---"
    grep $sta /proc/net/arp | awk '{print "\t IP: "$1" (from ARP table)"}'
    grep -i $sta /var/dhcp.leases | awk '{print "\t IP: "$3" (from DHCP Lease)\n\t NAME: "$4" (from DHCP Lease)"}'
  done
  echo "------------------------------------------------------"
done

