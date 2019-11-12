#!/bin/zsh -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

cp -fv ~/loadrc/hosts/`hostname`/etc/default/isc-dhcp-server /etc/default/isc-dhcp-server
cp -fv ~/loadrc/hosts/`hostname`/etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf

systemctl start isc-dhcp-server
systemctl enable isc-dhcp-server
service isc-dhcp-server restart

ufw allow  67/udp
#ufw reload
#ufw show
