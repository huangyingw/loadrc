#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

mkdir -p ~/loadrc/`hostname`/var/lib/zerotier-one/ ; cp -v /var/lib/zerotier-one/identity.* ~/loadrc/`hostname`/var/lib/zerotier-one/
