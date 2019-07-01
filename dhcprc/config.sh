#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

cp -fv ~/loadrc/hosts/`hostname`/etc/default/isc-dhcp-server /etc/default/isc-dhcp-server
