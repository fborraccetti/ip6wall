#!/bin/sh
. /etc/no-net-wall/no-net-wall.conf
$IPT -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
echo -n "Enablig NAT,FORWARD traffic for: "
	for x in $MAC_ADDR
	do
        echo -n " $x ,"
	$IPT -t filter -A FORWARD --match mac --mac-source $x -j ACCEPT
	done
echo done
echo -n "starting nat for $LAN_NET"		
#iptables -t filter -A FORWARD --match mac --mac-source 00:1A:92:0C:33:8E -j ACCEPT
#iptables -t filter -A FORWARD --match mac --mac-source 00:18:F3:E6:50:7D -j ACCEPT
#iptables -t filter -A FORWARD --match mac --mac-source 00:1A:92:0C:33:8F -j ACCEPT
$IPT -t nat -A POSTROUTING -s $LAN_NET -o $INET_IFACE -j MASQUERADE
echo 1 >  /proc/sys/net/ipv4/ip_forward 
echo 1 > /proc/sys/net/ipv4/ip_dynaddr
#client route add default gw 192.168.1.1
echo "done"
