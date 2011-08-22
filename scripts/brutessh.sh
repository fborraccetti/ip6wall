#taken from http://www.debian-administration.org/articles/187
# Change the value of external_if to the name of your Internet-facing interface!
external_if=ppp0
echo -n "starting Brute ssh protection "
/sbin/iptables --new-chain sshthrottle

/sbin/iptables --append sshthrottle \
       --match recent --update --seconds 15 --name sshthrottlelog \
       --jump DROP
 
/sbin/iptables --append sshthrottle \
       --match recent --set --name sshthrottlelog \
       --jump LOG --log-prefix "ssh connection stifled "

/sbin/iptables --append sshthrottle --jump DROP

/sbin/iptables --append INPUT --in-interface $external_if \
       --protocol tcp --destination-port 22 \
       --match state --state NEW \
       --match recent --update --seconds 15 --name sshthrottle \
       --jump sshthrottle

/sbin/iptables --append INPUT --in-interface $external_if \
       --protocol tcp --destination-port 22 \
       --match state --state NEW \
       --match recent --set --name sshthrottle \
       --jump ACCEPT
echo "done"
