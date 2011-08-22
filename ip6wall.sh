# This file is a part of Ip6wall.
# Ip6wall is a project of Fabio Borraccetti <miasma@no-net.org>.
# See Changelog for a list of changes.
# See COPYRIGHT for copyright infos.
# See INSTALL for installation infos.
# See LICENCE for license infos.

#!/bin/sh

. /etc/ip6wall/ip6wall.conf
ip=`host -t A $INET_HOST | cut -d" " -f 4`
###############################################################################

if [ "$1" = "stop" ]; then
	. $IP6PATH/stop
	exit
fi

###############################################################################


# Starting firewall

if [ "$1" = "start" ]; then
	. $IP6PATH/stop
	echo "Starting $VERSION ..."
	. $IP6PATH/module_load	
	. $IP6PATH/proc_setup
	. $IP6PATH/default_policies
	. $IP6PATH/chains
	. $IP6PATH/bad_packets
	. $IP6PATH/bad_tcp_packets
	. $IP6PATH/portscan	
	. $IP6PATH/icmp_packets
	# TCP & UDP
	# Identify ports at:
	#    http://www.chebucto.ns.ca/~rakerman/port-table.html
	#    http://www.iana.org/assignments/port-numbers
	. $IP6PATH/udp_inbound
	. $IP6PATH/udp_outbound chain
	. $IP6PATH/tcp_inbound chain
	. $IP6PATH/tcp_outbound 
	. $IP6PATH/forward
	####### NAT ##################################################################
	#if [ "$LAN" = "YES" ]; then
	#fi
	. $IP6PATH/input
	. $IP6PATH/output
fi
if [ "$DMZ" = "YES" ]; then
        echo -n "enabling all traffic for and to $DMZ_IP : "
        $IPT -A INPUT -s $DMZ_IP -p ALL -j ACCEPT
        $IPT -A OUTPUT -d $DMZ_IP -p ALL -j ACCEPT
        echo done;
fi
